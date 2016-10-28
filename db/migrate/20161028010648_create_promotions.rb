class CreatePromotions < ActiveRecord::Migration[5.0]
  def change
    create_table :promotions do |t|
      t.string :name
      t.string :description
      t.date :from_date
      t.date :to_date
      t.boolean :status
      t.float :full_price
      t.float :promo_price
      t.float :discount_percentage
      t.integer :priority
      t.integer :max_coupons

      t.boolean :deleted, default: false
      t.timestamps
    end

    add_index :promotions, [:name, :deleted], unique: true
  end
end
