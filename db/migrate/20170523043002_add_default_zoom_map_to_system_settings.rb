class AddDefaultZoomMapToSystemSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :system_settings, :default_zoom, :integer
  end
end
