class ChangeCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :parent_id, :integer, null: true, index: true
    add_column :categories, :lft, :integer, null: false, index: true
    add_column :categories, :rgt, :integer, null: false, index: true

      # optional fields
    add_column :categories, :depth, :integer, null: false, default: 0
    add_column :categories, :children_count, :integer, null: false, default: 0
  end
end
