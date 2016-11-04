class AddIdToPautaDetail < ActiveRecord::Migration[5.0]
  def up
    execute "ALTER TABLE pauta_detalle DROP CONSTRAINT pk_pauta_detalle"
    add_column :pauta_detalle, :id, :primary_key
  end

  def down
    remove_column :pauta_detalle, :id
    execute "ALTER TABLE pauta_detalle ADD CONSTRAINT pk_pauta_detalle UNIQUE (id_item_mantencion, id_pauta)"
  end
end
