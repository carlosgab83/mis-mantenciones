class FixIndexOnItemMantencion < ActiveRecord::Migration[5.0]

  def up
    remove_index :item_mantencion, name: :item_mantencion_business_index
    add_index :item_mantencion, [:id_item_mantencion], unique: true, name: :item_mantencion_business_index
  end

  def down
    remove_index :item_mantencion, name: :item_mantencion_business_index
    add_index :item_mantencion, [:desc_mantencion, :id_tipo_seccion], unique: true, name: :item_mantencion_business_index
  end
end
