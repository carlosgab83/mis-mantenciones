class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.float :amount, null: false
      t.string :session_id, null: false
      t.string :token, null: false
      t.string :status, null: false
      t.timestamps
    end

    add_reference :payments, :order, foreign_key: true, null: false

    add_index :payments, [:order_id, :amount, :created_at], unique: true, name: :payments_business_index
  end
end