class AddTimestampsToPautaDetalle < ActiveRecord::Migration[5.0]
  def change
    add_column(:pauta_detalle, :created_at, :datetime)
    add_column(:pauta_detalle, :updated_at, :datetime)
  end
end
