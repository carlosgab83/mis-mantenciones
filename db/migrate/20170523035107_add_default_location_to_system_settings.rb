class AddDefaultLocationToSystemSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :system_settings, :default_latitude, :float
    add_column :system_settings, :default_longitude, :float
  end
end
