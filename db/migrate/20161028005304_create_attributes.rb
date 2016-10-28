class CreateAttributes < ActiveRecord::Migration[5.0]
  def change
    create_table :attributes do |t|
      t.string :name
      t.boolean :deleted, default: false
      t.timestamps
    end

    add_index :attributes, [:name, :deleted], unique: true
  end
end
