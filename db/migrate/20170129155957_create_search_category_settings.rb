class CreateSearchCategorySettings < ActiveRecord::Migration[5.0]
  def change
    create_table :search_category_settings do |t|
      t.integer :filter_type, null: false
      t.integer :position
      t.boolean :deleted
      t.timestamps
    end

    add_reference :search_category_settings, :category,    foreign_key: true, null: false
    add_reference :search_category_settings, :attribute,    foreign_key: true, null: false

    add_index :search_category_settings, [:category_id, :attribute_id], unique: true, name: :search_category_settings_business_index
  end
end
