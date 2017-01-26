class AddRutAndShopNameToShopInscriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :shop_inscriptions, :company_name, :string
    add_column :shop_inscriptions, :company_rut, :string
  end
end
