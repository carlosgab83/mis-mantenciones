class PautaFinder < BaseService

  def call
    vme   = closest_vme(params[:vehicle])
    pauta = closest_pauta(vme.try(:vme_id), params[:vehicle].kms)
  end

  private

  # Finds closest pauta for fhis vme and km looking on all pautas for thar vme_id
  def closest_pauta(vme_id, km)
    closest_diff = 1000000
    winning_index = nil
    (pautas = Pauta.where(vme_id: vme_id)).each_with_index do |pauta, i|
      if (current_diff = (km - pauta.kilometraje).abs) < closest_diff
        closest_diff = current_diff
        winning_index = i
      end
    end

    # Error because not even there is generic pauta
    if vme_id.nil? and winning_index.nil?
      raise AppExceptions::PautaNotFound
    end

    return (winning_index.nil? ? closest_pauta(nil, km) : pautas[winning_index])
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
    (vmes = Vme.where(id_modelo: params[:vehicle].model_id).order(:vme_id)).each_with_index do |vme, i|
      if (size = (vme.vme_mod_especifico.split(' ') & vehicle.rvm_model.split(' ')).size) >= max_size
        winning_index = i
        max_size = size
      end
    end

    return vmes[winning_index]
  end
end
