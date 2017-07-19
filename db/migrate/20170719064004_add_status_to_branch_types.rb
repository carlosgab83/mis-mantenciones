class AddStatusToBranchTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :branch_types, :status, :boolean, default: true
  end
end
