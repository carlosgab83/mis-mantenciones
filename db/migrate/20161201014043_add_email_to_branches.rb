class AddEmailToBranches < ActiveRecord::Migration[5.0]
  def change
    add_column :branches, :email, :string
  end
end
