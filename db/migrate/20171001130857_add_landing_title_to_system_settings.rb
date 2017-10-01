class AddLandingTitleToSystemSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :system_settings, :landing_title, :string
  end
end
