class AddModeloEspecificoToPauta < ActiveRecord::Migration[5.0]
  def change
     add_column :pauta, :vme_id, :float
    add_foreign_key :pauta, :vehiculo_modelo_especifico, column: :vme_id, primary_key: :vme_id
    add_index :pauta, [:id_marca, :id_modelo, :vme_id, :kilometraje], unique: true, name: :pauta_business_index
  end
end
