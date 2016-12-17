class AddSlugToPromotionsAndProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :promotions, :slug, :string
    add_index :promotions, :slug
    add_column :products, :slug, :string
    add_index :products, :slug
  end
end
