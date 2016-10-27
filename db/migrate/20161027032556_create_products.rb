class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.boolean :deleted, default: false
      t.timestamps
    end

    add_index :products, [:name, :deleted], unique: true

    add_reference :products, :category,      foreign_key: true
    add_reference :products, :product_type,  foreign_key: true
    add_reference :products, :product_brand, foreign_key: true
  end
end
