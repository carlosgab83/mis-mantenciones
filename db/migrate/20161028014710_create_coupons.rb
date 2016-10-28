class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.date :date
      t.float :price

      t.boolean :deleted, default: false
      t.timestamps
    end

    add_reference :coupons, :promotion, foreign_key: true
    add_reference :coupons, :client,    foreign_key: true
  end
end
