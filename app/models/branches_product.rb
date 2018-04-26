class BranchesProduct < ApplicationRecord
  belongs_to :branch
  belongs_to :product

  FOLLOW_PRODUCT_URL = 0
  MISMANTENCIONES_CHECKOUT = 1

  scope :with_url, -> do
    where.not(url:'').where.not(url: nil)
  end

  after_save :update_product_min_price

  def cached_price
    # return 0 if Rails.env.development?
    return 250000 if Rails.env.development?
    db_minutes = SystemSetting.config.try(:product_scraping_caching_minutes) || 2
    Rails.cache.fetch("#{cache_key}_cached_price_#{branch_id}_#{product_id}", expires_in: db_minutes.minutes) do
      _price = ProductScraper::Base.new.scraper_instance(url).price

      Thread.new{
        self.price = _price
        save
      }

      _price
    end
  end

  def price
    scraping? ? cached_price : attributes["price"]
  end

  def update_product_min_price
    product.update_price
  end

  def buyable_item
    product
  end

  def is_mismantenciones_checkout?
    branch.mismantenciones_checkout? or (branch.delegate_to_product? and mismantenciones_checkout?)
  end

  # Decide checkout method

  def mismantenciones_checkout?
    checkout_method == MISMANTENCIONES_CHECKOUT
  end

  # Read automatically by rails_admin
  def checkout_method_enum
    [['Seguir la url del producto', FOLLOW_PRODUCT_URL], ['Ir al checkout de Mismantenciones.com', MISMANTENCIONES_CHECKOUT]]
  end
end
