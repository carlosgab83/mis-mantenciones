class RemoveEnviosMailCliente < ActiveRecord::Migration[5.0]
  def change
    drop_table :envios_mail_cliente
  end
end
