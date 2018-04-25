class AddInstallationEnabledAndlicknCollectEnabledAndDeliveryEnabledToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :installation_enabled, :boolean
    add_column :shops, :click_n_collect_enabled, :boolean
    add_column :shops, :delivery_enabled, :boolean
  end
end
