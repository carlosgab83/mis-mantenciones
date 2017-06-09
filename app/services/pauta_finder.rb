class PautaFinder < BaseService

  def call
    vme   = params[:vehicle].vme
    Rails.cache.fetch("#results_closest_pauta_#{vme.try(:vme_id)}_#{params[:vehicle].kms}", expires_in: 5.minutes) do
      pauta = closest_pauta(vme.try(:vme_id), params[:vehicle].kms)
    end
  end

  private

  # Finds closest pauta for fhis vme and km looking on all pautas for thar vme_id
  def closest_pauta(vme_id, km)
    closest_diff = 9999999999
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
end