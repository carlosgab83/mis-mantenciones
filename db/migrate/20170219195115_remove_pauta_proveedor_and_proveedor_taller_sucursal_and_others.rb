class RemovePautaProveedorAndProveedorTallerSucursalAndOthers < ActiveRecord::Migration[5.0]
  def change
    drop_table :proveedor_item_mantencion
    drop_table :pauta_proveedor
    drop_table :solicitud_agendamiento
    drop_table :proveedor_taller_sucursal
  end
end
