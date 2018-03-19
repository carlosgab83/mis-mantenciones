class AddInfoEmailToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :info_email, :string
  end
end
