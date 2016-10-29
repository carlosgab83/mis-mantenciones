class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.boolean :deleted, default: false
      t.timestamps
    end

    add_index :categories, [:name, :deleted], unique: true
  end
end
