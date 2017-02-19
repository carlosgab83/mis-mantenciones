class RemoveSolicitudEncuestaAndOthers < ActiveRecord::Migration[5.0]
  def change
    drop_table :solicitud_enc_alternativas
    drop_table :solicitud_encuesta
  end
end
