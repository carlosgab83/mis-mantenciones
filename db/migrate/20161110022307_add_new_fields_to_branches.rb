class AddNewFieldsToBranches < ActiveRecord::Migration[5.0]
  def change
    add_column :branches, :commune_id, :integer
    add_foreign_key :branches, :comuna, column: :commune_id, primary_key: :id_comuna
    add_column :branches, :street_address, :string
    add_column :branches, :number_address, :string
    add_column :branches, :ref_address, :string
  end
end
