class RemoveComuneRequiredFromClients < ActiveRecord::Migration[5.0]
  def up
    change_column :clients, :comune_id, :integer, null: true
  end

  def down
    change_column :clients, :comune_id, :integer, null:false
  end
end
