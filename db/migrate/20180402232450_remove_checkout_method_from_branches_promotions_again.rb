class RemoveCheckoutMethodFromBranchesPromotionsAgain < ActiveRecord::Migration[5.0]
  def change
    remove_column :branches_promotions, :checkout_method
  end
end
