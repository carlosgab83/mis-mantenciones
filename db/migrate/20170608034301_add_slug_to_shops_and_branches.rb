class AddSlugToShopsAndBranches < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :slug, :string
    add_column :branches, :slug, :string
  end
end
