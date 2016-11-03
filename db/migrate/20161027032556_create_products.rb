class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.boolean :deleted, default: false
      t.timestamps
    end

    add_index :products, [:name], unique: true, name: :products_business_index

    add_reference :products, :category,      foreign_key: true, null: false
    add_reference :products, :product_type,  foreign_key: true, null: false
    add_reference :products, :product_brand, foreign_key: true, null: false
  end
end
