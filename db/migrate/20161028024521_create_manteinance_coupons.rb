class CreateManteinanceCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :manteinance_coupons do |t|
      t.float :price, null: false
      t.date :date, null: false
      t.integer :pauta_id, null: false

      t.boolean :deleted, default: false
      t.timestamps
    end

    add_reference :manteinance_coupons, :branch,    foreign_key: true, null: false
    add_reference :manteinance_coupons, :client,    foreign_key: true, null: false
    add_foreign_key :manteinance_coupons, :pauta, column: :pauta_id, primary_key: :id_pauta
  end
end
