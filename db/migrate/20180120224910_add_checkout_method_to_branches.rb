class AddCheckoutMethodToBranches < ActiveRecord::Migration[5.0]
  def change
    add_column :branches, :checkout_method, :integer, default: 0
  end
end
