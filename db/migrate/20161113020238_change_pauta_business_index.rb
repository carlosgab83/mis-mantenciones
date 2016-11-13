class ChangePautaBusinessIndex < ActiveRecord::Migration[5.0]
  def change
    remove_index :pauta, name: :pauta_business_index, column: [:id_marca, :id_modelo, :vme_id, :kilometraje, :double_traction, :diesel_engine, :automatic_transmission], unique: true
    add_index :pauta, [:id_marca, :id_modelo, :vme_id, :kilometraje, :double_traction, :diesel_engine, :automatic_transmission], unique: true, name: :pauta_business_index
  end
end
