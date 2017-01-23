class CreateShopInscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :shop_inscriptions do |t|
      t.string :name, null: false
      t.string :primary_last_name
      t.string :email, null: false
      t.string :phone
      t.string :rut
      t.integer :comune_id, null: false
      t.boolean :deleted, default: false
      t.timestamps
    end

    add_index :shop_inscriptions, [:email], unique: true, name: :shop_inscriptions_business_index

    add_foreign_key :shop_inscriptions, :comuna, column: :comune_id, primary_key: "id_comuna", null: false
  end
end
