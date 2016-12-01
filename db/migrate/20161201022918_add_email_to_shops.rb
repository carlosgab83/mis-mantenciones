class AddEmailToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :email, :string
  end
end
