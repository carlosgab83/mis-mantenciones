class CreateBranchesProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :branches_products do |t|
      t.float :price, null: false
      t.date :from_date
      t.date :to_date
      t.boolean :status, null: false
      t.integer :stock
      t.string :url

      t.boolean :deleted, default: false
      t.timestamps
    end

    add_reference :branches_products, :branch,    foreign_key: true, null: false
    add_reference :branches_products, :product,    foreign_key: true, null: false
  end
end
