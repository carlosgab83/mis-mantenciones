class ChangeContactSellerFromOrders < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :contact_seller, :string
  end
end
