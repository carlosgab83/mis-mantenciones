class CreateBranchTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :branch_types do |t|
      t.string :name, null: false
      t.string :marker_url, null: false
      t.boolean :deleted, default: false
      t.timestamps
    end

    add_index :branch_types, [:name], unique: true, name: :branch_types_business_index
  end
end
