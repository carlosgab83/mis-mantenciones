class AddAlwaysUseDefaultZoomToSystemSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :system_settings, :always_use_default_zoom, :boolean
  end
end
