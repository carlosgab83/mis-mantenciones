class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.string :description
      t.boolean :deleted, default: false
      t.timestamps
    end

    add_index :plans, [:name], unique: true, name: :plans_business_index
  end
end
