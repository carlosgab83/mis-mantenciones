class VehicleFinder < BaseService

  def call
    row = (execute query params.patent).first
    vehicle = Vehicle.new(row, params.patent, params.kms)
    vehicle.vme = closest_vme(vehicle)
    vehicle
  end

  private

  def query(patent)
    query = ActiveRecordHelper.sanitize_sql(["select v_marca, v_modelo, v_ano_fab, v_cod_marca, v_cod_modelo, v_motor, v_chasis, v_cod_tveh
      from v_rvm_vehiculo where v_rvm= ?", params.patent])
  end

  # Comparing the vehicle model string vs table vehiculo_modelo_especifico model string:
  # e.g.
  #    Vehicle model: "PASSAT FSI 2.0 TIPTRONIC" => ["PASSAT", "FSI", "2.0", "TIPTRONIC"]
  #    vehiculo_modelo_especifico model strings (some):
  #         - "PASSAT"   => ["PASSAT"]
  #          - "TDI 2.0" => ["TDI", "2.0"]
  #          - "2.0 FSI" => ["2.0", "FSI"]
  # Then, winning is: "2.0 FSI" because intersection.size with Vehicle model is 2 (the maximum)-
  # If intersection.size == 0, then winnin_index gonna be 0, then first vme will be winner.
  # this is goog because the first vme always is the generic vme
  def closest_vme(vehicle)
    max_size = 0
    winning_index = 0
    (vmes = Vme.where(id_modelo: vehicle.model_id).order(:vme_id)).each_with_index do |vme, i|
      if (size = (vme.vme_mod_especifico.split(' ') & vehicle.rvm_model.split(' ')).size) >= max_size
        winning_index = i
        max_size = size
      end
    end

    return vmes[winning_index]
  end
end
