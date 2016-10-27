class CreateProductBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :product_brands do |t|
      t.string :name
      t.boolean :deleted, default: false
      t.timestamps
    end

    add_index :product_brands, [:name, :deleted], unique: true
  end
end
