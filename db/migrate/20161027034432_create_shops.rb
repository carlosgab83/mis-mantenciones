class CreateShops < ActiveRecord::Migration[5.0]
  def change
    create_table :shops do |t|
      t.string :name, null: false
      t.string :rut, null: false
      t.boolean :deleted, default: false
      t.timestamps
    end

    add_index :shops, [:name, :deleted], unique: true
    add_index :shops, [:rut, :deleted],  unique: true
  end
end
