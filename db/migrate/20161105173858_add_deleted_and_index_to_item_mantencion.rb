class AddDeletedAndIndexToItemMantencion < ActiveRecord::Migration[5.0]
  def change
    add_column :item_mantencion, :deleted, :boolean, default: false
    add_index :item_mantencion, [:desc_mantencion, :id_tipo_seccion], unique: true, name: :item_mantencion_business_index
  end
end
