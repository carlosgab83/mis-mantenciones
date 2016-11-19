class CreateManteinanceCouponsItems < ActiveRecord::Migration[5.0]
  def change
    create_table :manteinance_coupons_items do |t|
      t.integer :manteinance_item_id, null: false
      t.float :price, null: false
      t.boolean :deleted, default: false
      t.timestamps
    end

    add_reference :manteinance_coupons_items, :manteinance_coupon,    foreign_key: true, null: false
    add_foreign_key :manteinance_coupons_items, :item_mantencion, column: :manteinance_item_id, primary_key: :id_item_mantencion

    add_index :manteinance_coupons_items, [:manteinance_item_id, :manteinance_coupon_id], unique: true, name: :manteinance_coupons_items_business_index
  end
end
