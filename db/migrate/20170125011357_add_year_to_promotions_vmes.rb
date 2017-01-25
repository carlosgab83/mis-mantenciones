class AddYearToPromotionsVmes < ActiveRecord::Migration[5.0]
  def change
    add_column :promotions_vmes, :from_year, :integer
    add_column :promotions_vmes, :to_year, :integer
  end
end
