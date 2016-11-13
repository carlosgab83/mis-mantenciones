class AddAutoIncrementAndRemoveUniqueIndexToPauta < ActiveRecord::Migration[5.0]
  def up
    execute "CREATE SEQUENCE pauta_id_pauta_seq START 101"
    execute "ALTER TABLE pauta ALTER COLUMN id_pauta SET DEFAULT nextval('pauta_id_pauta_seq'::regclass)"
    remove_index :pauta, name: :pauta_business_index
    add_index :pauta, [:id_pauta, :id_marca, :id_modelo, :vme_id, :kilometraje], unique: true, name: :pauta_business_index
  end

  def down
    execute "DROP SEQUENCE pauta_id_pauta_seq CASCADE"
    execute "ALTER TABLE pauta ALTER COLUMN id_pauta SET DEFAULT 0"
    remove_index :pauta, name: :pauta_business_index
    add_index :pauta, [:id_marca, :id_modelo, :vme_id, :kilometraje], unique: true, name: :pauta_business_index
  end
end
