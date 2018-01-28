class CreateOrder < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :order_number, null: false
      t.string :email, null: false
      t.string :rut, null: false
      t.string :name, null: false
      t.string :primary_last_name, null: false
      t.string :phone
      t.string :street_address
      t.string :number_address
      t.string :region
      t.integer :commune_id
      t.boolean :contact_seller
      t.string :full_name
      t.string :contact_phone
      t.string :accept_terms
      t.string :status
      t.timestamps
    end

    add_reference :orders, :client, foreign_key: true, null: false
    add_reference :orders, :cart, foreign_key: true, null: false
    add_reference :orders, :branch, foreign_key: true, null: false

    add_index :orders, [:cart_id, :client_id, :created_at], unique: true, name: :orders_business_index
  end
end
