class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.float :price, null: false
      t.timestamps
    end

    add_reference :carts, :client, foreign_key: true, null: false

    add_index :carts, [:client_id, :price, :created_at], unique: true, name: :carts_business_index
  end
end
