class ChangePriceOnBranchesProducts < ActiveRecord::Migration[5.0]
  def up
    change_column :branches_products, :price, :float, null: true
  end

  def down
    change_column :branches_products, :price, :float, null:false
  end
end
