class CreateCouponsPautas < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons_pautas do |t|
      t.float :price
      t.date :date
      t.integer :pauta_id

      t.boolean :deleted, default: false
      t.timestamps
    end

    add_reference :coupons_pautas, :branch,    foreign_key: true
    add_reference :coupons_pautas, :client,    foreign_key: true
    add_foreign_key :coupons_pautas, :pauta, column: :pauta_id, primary_key: :id_pauta
  end
end
