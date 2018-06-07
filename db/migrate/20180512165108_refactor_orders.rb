class RefactorOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :full_name, :string
    add_column :orders, :retirement_type, :string
  end
end
