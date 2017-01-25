class AddYearRangeToProductsVmes < ActiveRecord::Migration[5.0]
  def change
    add_column :products_vmes, :from_year, :integer
    add_column :products_vmes, :to_year, :integer
  end
end
