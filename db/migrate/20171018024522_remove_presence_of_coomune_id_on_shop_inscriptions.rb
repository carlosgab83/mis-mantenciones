class RemovePresenceOfCoomuneIdOnShopInscriptions < ActiveRecord::Migration[5.0]
  def change
    change_column :shop_inscriptions, :comune_id, :integer, null: true
  end
end
