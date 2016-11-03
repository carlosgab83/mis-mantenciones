class CreateProductBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :product_brands do |t|
      t.string :name
      t.boolean :deleted, default: false
      t.timestamps
    end

    add_index :product_brands, [:name], unique: true, name: :product_brands_business_index
  end
end
