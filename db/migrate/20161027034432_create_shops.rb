class CreateShops < ActiveRecord::Migration[5.0]
  def change
    create_table :shops do |t|
      t.string :name, null: false
      t.string :rut, null: false
      t.boolean :deleted, default: false
      t.timestamps
    end

    add_index :shops, [:name], unique: true, name: :shops_business_index
    add_index :shops, [:rut],  unique: true
  end
end
