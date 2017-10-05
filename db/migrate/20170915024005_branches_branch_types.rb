class BranchesBranchTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :branches_branch_types do |t|
      t.boolean :deleted, default: false
      t.timestamps
    end

    add_reference :branches_branch_types, :branch,    foreign_key: true
    add_reference :branches_branch_types, :branch_type, foreign_key: true

    add_index :branches_branch_types, [:branch_id, :branch_type_id], unique: true, name: :branches_branch_types_business_index
  end
end
