class AddCheckoutMethodToBranchesProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :branches_products, :checkout_method, :integer, default: 0
  end
end
