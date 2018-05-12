class AddInstallationsToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :branch_installation, :boolean
    add_column :orders, :delivery_installation, :boolean
  end
end
