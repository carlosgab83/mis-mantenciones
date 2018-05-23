class CreateHomeBanners < ActiveRecord::Migration[5.0]
  def change
    create_table :home_banners do |t|
      t.string  :name, null: false
      t.string  :title, null: false
      t.string  :subtitle, null: false
      t.string  :image_url, null: false
      t.string  :image_click_url, null: false
      t.string  :button_text, null: false
      t.string  :button_click_url, null: false
      t.boolean :image_click_new_page, null: false, default: false
      t.boolean :button_click_new_page, null: false, default: false
      t.date    :from_date, null: false
      t.date    :to_date, null: false
      t.integer :priority, null: false
      t.boolean :status, default: false

      t.boolean :deleted, default: false
      t.timestamps
    end

    add_index :home_banners, [:name], unique: true, name: :home_banners_business_index
  end
end
