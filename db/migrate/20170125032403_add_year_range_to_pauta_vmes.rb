class AddYearRangeToPautaVmes < ActiveRecord::Migration[5.0]
  def change
    add_column :pauta, :from_year, :integer
    add_column :pauta, :to_year, :integer
  end
end
