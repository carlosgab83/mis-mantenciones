class AddKmsToPromotions < ActiveRecord::Migration[5.0]
  def change
    add_column :promotions, :kms, :integer
  end
end
