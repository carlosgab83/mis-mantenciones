class DeleteDeprecatedTables < ActiveRecord::Migration[5.0]
  def change
    drop_table :pauta_detalle
    drop_table :branches_manteinance_items
    drop_table :manteinance_coupons_items
    drop_table :manteinance_coupons
    drop_table :item_mantencion
    drop_table :pauta
  end
end
