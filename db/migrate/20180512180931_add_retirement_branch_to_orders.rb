class AddRetirementBranchToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :retirement_branch, :string
  end
end
