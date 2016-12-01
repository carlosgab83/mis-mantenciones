class ChangePriceOnCoupons < ActiveRecord::Migration[5.0]
  def up
    change_column :coupons, :price, :float, null: true
  end

  def down
    change_column :coupons, :price, :float, null:false
  end
end
