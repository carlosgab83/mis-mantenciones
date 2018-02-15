class BranchesProduct < ApplicationRecord
  belongs_to :branch
  belongs_to :product

  FOLLOW_PRODUCT_URL = 0
  MISMANTENCIONES_CHECKOUT = 1

  scope :with_url, -> do
    where.not(url:'').where.not(url: nil)
  end

  def cached_price
    # return 0 if Rails.env.development?
    return 250000 if Rails.env.development?
    db_minutes = SystemSetting.config.try(:product_scraping_caching_minutes) || 2
    Rails.cache.fetch("#{cache_key}_cached_price_#{branch_id}_#{product_id}", expires_in: db_minutes.minutes) do
      _price = ProductScraper::Base.new.scraper_instance(url).price
      self.price = _price
      save
      _price
    end
  end

  def price
    return 20 if id == 59
    cached_price
  end

  def buyable_item
    product
  end

  # Decide checkout method

  def mismantenciones_checkout?
    checkout_method == MISMANTENCIONES_CHECKOUT
  end
end
