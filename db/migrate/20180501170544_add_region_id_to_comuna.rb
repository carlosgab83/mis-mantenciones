class AddRegionIdToComuna < ActiveRecord::Migration[5.0]
  def change
    add_column :comuna, :region_id, :integer, null: false, default: 0
  end
end
