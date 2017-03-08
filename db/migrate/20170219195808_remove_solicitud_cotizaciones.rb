class RemoveSolicitudCotizaciones < ActiveRecord::Migration[5.0]
  def change
    drop_table :solicitud_cotizaciones
  end
end
