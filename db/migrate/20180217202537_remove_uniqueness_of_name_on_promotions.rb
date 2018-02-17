class RemoveUniquenessOfNameOnPromotions < ActiveRecord::Migration[5.0]
  def change
    remove_index :promotions, name: :promotions_business_index
    add_index :promotions, [:name, :slug], unique: true, name: :promotions_business_index
  end
end
