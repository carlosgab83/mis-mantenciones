class AddStatusToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :status, :boolean
  end
end
