class AddFieldsToClients < ActiveRecord::Migration[5.0]
  def change
  	add_column :clients, :manteinance_type, :string
  	add_column :clients, :brand, :string
  	add_column :clients, :message, :text
  end
end
