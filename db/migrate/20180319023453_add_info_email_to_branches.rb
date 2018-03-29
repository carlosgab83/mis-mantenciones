class AddInfoEmailToBranches < ActiveRecord::Migration[5.0]
  def change
    add_column :branches, :info_email, :string
  end
end
