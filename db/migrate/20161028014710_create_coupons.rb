class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.date :date, null: false
      t.float :price, null: false

      t.boolean :deleted, default: false
      t.timestamps
    end

    add_reference :coupons, :promotion, foreign_key: true, null: false
    add_reference :coupons, :client,    foreign_key: true, null: false
  end
end
