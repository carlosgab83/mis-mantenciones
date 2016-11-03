class CreateAttributesProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :attributes_products do |t|
      t.boolean :deleted, default: false
      t.timestamps
    end

    add_reference :attributes_products, :attribute, foreign_key: true, null: false
    add_reference :attributes_products, :product,   foreign_key: true, null: false

    add_index :attributes_products, [:attribute_id, :product_id], unique: true, name: :attributes_products_business_index
  end
end
