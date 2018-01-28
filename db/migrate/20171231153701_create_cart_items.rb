class CreateCartItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_items do |t|
      t.references :buyable, polymorphic: true, index: true
      t.float :unit_price
      t.integer :quantity
      t.timestamps
    end

    add_reference :cart_items, :cart, foreign_key: true, null: false

    add_index :cart_items, [:buyable_type, :buyable_id, :cart_id, :created_at], unique: true, name: :cart_items_business_index
  end
end