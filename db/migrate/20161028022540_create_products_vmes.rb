class CreateProductsVmes < ActiveRecord::Migration[5.0]
  def change
    create_table :products_vmes do |t|
      t.float :vme_id

      t.boolean :deleted, default: false
      t.timestamps
    end

    add_reference :products_vmes,   :product, foreign_key: true, null: false
    add_foreign_key :products_vmes, :vehiculo_modelo_especifico, column: :vme_id, primary_key: :vme_id

    add_index :products_vmes, [:product_id, :vme_id], unique: true, name: :products_vmes_business_index
  end
end
