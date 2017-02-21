class VehicleFinder < BaseService

  def call
    row = nil
    if params.patent.present?
      patent = adjust(params.patent)
      row = (execute query patent).first
    end
    vehicle = Vehicle.new(row, patent, params.kms)
    vehicle.vme = closest_vme(vehicle)
    vehicle
  end

  private

  def query(patent)
    query = ActiveRecordHelper.sanitize_sql(["select v_marca, v_modelo, v_ano_fab, v_cod_marca, v_cod_modelo, v_motor, v_chasis, v_cod_tveh
      from v_rvm_vehiculo where v_rvm= ?", patent])
  end

  # ALROGITHM REWROTE: MUST TO REWRITE THIS DESCRIPTION
  # Comparing the vehicle model string vs table vehiculo_modelo_especifico model string:
  # e.g.
  #    Vehicle model: "PASSAT FSI 2.0 TIPTRONIC" => ["PASSAT", "FSI", "2.0", "TIPTRONIC"]
  #    vehiculo_modelo_especifico model strings (some):
  #         - "PASSAT"   => ["PASSAT"]
  #          - "TDI 2.0" => ["TDI", "2.0"]
  #          - "2.0 FSI" => ["2.0", "FSI"]
  #          - "2.0 FSI AUT" => ["2.0", "FSI", "AUT"]
  # Then, winning is: "2.0 FSI" because intersection.size with Vehicle model is 2 (the maximum)-
  # If intersection.size == 0, then winnin_index gonna be 0, then first vme will be winner.
  # this is goog because the first vme always is the generic vme
  # In addition, if the intersection size is the same, the most percentage row of the word that
  # was intersected is the winning
  def closest_vme(vehicle)
    max_percentage = 0
    winning_index = 0
    vehicle_splitted = vehicle.rvm_model.try(:split, ' ') || []
    vehicle_splitted.delete((vehicle.table_model_name || '').strip)
    (vmes = Vme.where(id_modelo: vehicle.model_id).order(:vme_id)).each_with_index do |vme, i|
      vme_splitted = vme.vme_mod_especifico.split(' ')
      quantity = (vme_splitted & vehicle_splitted).size
      percentage = quantity.to_f / vme_splitted.size
      if percentage > max_percentage
        winning_index = i
        max_percentage = percentage
      end
    end

    return vmes[winning_index]
  end

  # For Motorcycles, if patent has 5 characters, one '0' must be inserted after last letter
  # It assumes that patent has 5 or 6 characters. Not other option
  def adjust(patent)
    return patent unless patent.length < 6
    i = first_number_index(patent)
    "#{patent[0..(i-1)]}0#{patent[i..-1]}"
  end

  def first_number_index(patent)
    patent.index(/[0123456789]/)
  end
end
