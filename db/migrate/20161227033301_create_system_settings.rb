class CreateSystemSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :system_settings do |t|
      t.integer :product_scraping_caching_minutes, null: false
      t.timestamps
    end
  end
end
