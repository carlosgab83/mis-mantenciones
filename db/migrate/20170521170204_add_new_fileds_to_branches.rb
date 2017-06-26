class AddNewFiledsToBranches < ActiveRecord::Migration[5.0]
  def change
    add_reference :branches, :branch_type, foreign_key: true
    add_reference :branches, :plan, foreign_key: true
    add_column :branches, :latitude, :float
    add_column :branches, :longitude, :float
    add_column :branches, :interval_between_jumps, :float
  end
end