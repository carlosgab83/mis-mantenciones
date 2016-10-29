class CreateBranches < ActiveRecord::Migration[5.0]
  def change
    create_table :branches do |t|
      t.string :name, null: false
      t.string :phone1
      t.string :phone2
      t.string :address
      t.boolean :will_contact, null: false
      t.string :booking_url
      t.string :scraper_model

      t.boolean :deleted, default: false
      t.timestamps
    end

    add_index :branches, [:name, :deleted], unique: true

    add_reference :branches, :shop, foreign_key: true, null: false
  end
end
