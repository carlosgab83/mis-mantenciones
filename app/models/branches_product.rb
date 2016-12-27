class BranchesProduct < ApplicationRecord
  belongs_to :branch
  belongs_to :product

  scope :with_url, -> do
    where.not(url:'').where.not(url: nil)
  end

  def cached_price
    # return 0 if Rails.env.development?
    db_minutes = SystemSetting.config.try(:product_scraping_caching_minutes) || 2
    return nil if url.nil? or url.blank?
    Rails.cache.fetch("#{cache_key}_cached_price_#{branch_id}_#{product_id}", expires_in: db_minutes.minutes) do
      ProductScraper::Base.new.scraper_instance(url).price
    end
  end
end
