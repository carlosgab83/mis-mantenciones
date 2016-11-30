class AddUniqueIndexToPauta < ActiveRecord::Migration[5.0]
  def change
    add_index :pauta, [:kilometraje, :vme_id, :diesel_engine, :double_traction, :automatic_transmission], unique: true, name: :pauta_business_index
  end
end
