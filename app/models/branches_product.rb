class BranchesProduct < ApplicationRecord
  belongs_to :branch
  belongs_to :product

  def cached_price
    Rails.cache.fetch("#{cache_key}_cached_price_#{branch_id}_#{product_id}", expires_in: 5.minutes) do
      ProductScraper::Base.new.scraper_instance(url).price
    end
  end
end
