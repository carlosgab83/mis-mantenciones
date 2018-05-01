class ChangeDefaultValuesAndTypesOfThisFields < ActiveRecord::Migration[5.0]
  def change
    remove_column :shops, :installation_enabled
    add_column :shops, :installation_enabled, :integer, default: 3, null: false
    change_column :shops, :click_n_collect_enabled, :boolean, default: true, null: false
    change_column :shops, :delivery_enabled, :boolean, default: false, null: false
  end
end
