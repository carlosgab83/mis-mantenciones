class RemoveDefaultValueFromShopClickNCollectOptions < ActiveRecord::Migration[5.0]
  def change
    change_column_default :shops, :installation_enabled, nil
    change_column_default :shops, :click_n_collect_enabled, nil
    change_column_default :shops, :delivery_enabled, nil
  end
end
