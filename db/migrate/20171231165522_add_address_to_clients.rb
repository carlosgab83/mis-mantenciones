class AddAddressToClients < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :street_address, :string
    add_column :clients, :number_address, :string
    add_column :clients, :region, :string
  end
end
