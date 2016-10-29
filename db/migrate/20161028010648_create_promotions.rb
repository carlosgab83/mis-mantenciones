class CreatePromotions < ActiveRecord::Migration[5.0]
  def change
    create_table :promotions do |t|
      t.string :name, null: false
      t.string :description
      t.date :from_date
      t.date :to_date
      t.boolean :status, null: false
      t.float :full_price, null: false
      t.float :promo_price, null: false
      t.float :discount_percentage
      t.integer :priority, null: false
      t.integer :max_coupons

      t.boolean :deleted, default: false
      t.timestamps
    end

    add_index :promotions, [:name, :deleted], unique: true
  end
end
