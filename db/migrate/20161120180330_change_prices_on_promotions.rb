class ChangePricesOnPromotions < ActiveRecord::Migration[5.0]
  def up
    change_column :promotions, :promo_price, :float, null: true
    change_column :promotions, :full_price, :float, null: true
    change_column :promotions, :discount_percentage, :float, null: true
  end

  def down
    change_column :promotions, :promo_price, :float, null:false
    change_column :promotions, :full_price, :float, null: false
    change_column :promotions, :discount_percentage, :float, null: false
  end
end
