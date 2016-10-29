class CreateProductTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :product_types do |t|
      t.string :name, null: false
      t.boolean :deleted, default: false
      t.timestamps
    end

    add_index :product_types, [:name, :deleted], unique: true
  end
end
