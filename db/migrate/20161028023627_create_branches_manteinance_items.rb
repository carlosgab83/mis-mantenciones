class CreateBranchesManteinanceItems < ActiveRecord::Migration[5.0]
  def change
    create_table :branches_manteinance_items do |t|
      t.integer :manteinance_item_id, null: false
      t.integer :pauta_id, null: false
      t.float :full_price, null: false
      t.float :promo_price, null: false
      t.float :discount_percentage

      t.boolean :deleted, default: false
      t.timestamps
    end

    add_reference :branches_manteinance_items, :branch,    foreign_key: true, null: false
    add_foreign_key :branches_manteinance_items, :item_mantencion, column: :manteinance_item_id, primary_key: :id_item_mantencion
    add_foreign_key :branches_manteinance_items, :pauta, column: :pauta_id, primary_key: :id_pauta

    add_index :branches_manteinance_items, [:manteinance_item_id, :pauta_id, :branch_id], unique: true, name: :branches_manteinance_items_business_index

  end
end
