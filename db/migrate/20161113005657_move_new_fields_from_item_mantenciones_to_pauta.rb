class MoveNewFieldsFromItemMantencionesToPauta < ActiveRecord::Migration[5.0]
  def change
    remove_column :item_mantencion, :double_traction
    remove_column :item_mantencion, :diesel_engine
    remove_column :item_mantencion, :automatic_transmission

    add_column :pauta, :double_traction, :boolean
    add_column :pauta, :diesel_engine, :boolean
    add_column :pauta, :automatic_transmission, :boolean
  end
end
