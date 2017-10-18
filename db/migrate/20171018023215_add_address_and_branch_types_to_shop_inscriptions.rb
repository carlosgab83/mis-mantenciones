class AddAddressAndBranchTypesToShopInscriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :shop_inscriptions, :address, :string
    add_column :shop_inscriptions, :branch_types, :string
  end
end
