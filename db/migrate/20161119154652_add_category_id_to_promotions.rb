class AddCategoryIdToPromotions < ActiveRecord::Migration[5.0]
  def change
    add_reference :promotions, :category,    foreign_key: true, null: false
  end
end
