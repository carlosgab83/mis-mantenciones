class AddNewFieldsToPromotions < ActiveRecord::Migration[5.0]
  def change
    add_column :promotions, :button_type, :integer
    add_column :promotions, :button_text, :string
  end
end
