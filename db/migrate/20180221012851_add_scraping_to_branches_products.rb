class AddScrapingToBranchesProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :branches_products, :scraping, :boolean, default: true
  end
end
