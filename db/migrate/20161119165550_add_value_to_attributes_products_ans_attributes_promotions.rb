class AddValueToAttributesProductsAnsAttributesPromotions < ActiveRecord::Migration[5.0]
  def change
    add_column :attributes_products, :value, :string
    add_column :attributes_promotions, :value, :string
  end
end
