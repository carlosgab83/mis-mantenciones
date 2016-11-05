class AddDeletedAndIndexToPautaDetalle < ActiveRecord::Migration[5.0]
  def change
    add_column :pauta_detalle, :deleted, :boolean, default: false
    add_index :pauta_detalle, [:id_pauta, :id_item_mantencion], unique: true, name: :pauta_detalle_business_index
  end
end
