class AddTypeToPromotions < ActiveRecord::Migration[5.0]
  def change
    add_column :promotions, :type, :string
    add_index :promotions, :type
  end
end
