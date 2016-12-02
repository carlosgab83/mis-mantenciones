class AddImageUrlToPromotions < ActiveRecord::Migration[5.0]
  def change
    add_column :promotions, :image_url, :string
  end
end
