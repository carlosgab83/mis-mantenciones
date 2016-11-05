class AddDeletedToPauta < ActiveRecord::Migration[5.0]
  def change
    add_column :pauta, :deleted, :boolean, default: false
  end
end
