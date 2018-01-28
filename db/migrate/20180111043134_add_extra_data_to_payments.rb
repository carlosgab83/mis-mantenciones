class AddExtraDataToPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :extra_data, :string
  end
end
