class AddNewFieldsToItemMantencion < ActiveRecord::Migration[5.0]
  def change
    add_column :item_mantencion, :double_traction, :boolean
    add_column :item_mantencion, :diesel_engine, :boolean
    add_column :item_mantencion, :automatic_transmission, :boolean
  end
end
