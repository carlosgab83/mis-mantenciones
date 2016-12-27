class AddStatusToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :status, :boolean, default: false
  end
end
