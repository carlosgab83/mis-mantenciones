class AddPriceToBranchesPromotions < ActiveRecord::Migration[5.0]
  def change
    add_column :branches_promotions, :price, :float
  end
end
