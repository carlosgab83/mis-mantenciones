class ManteinanceCouponsController < ApplicationController
  protect_from_forgery with: :exception

  # GET /manteinance_coupons/new?pauta[id_pauta]=476
  def new
    if pauta_params
      manteinance_alternatives_list = ManteinanceAlternativesListComposer.new(pauta_params).call
      if manteinance_alternatives_list
        render json: manteinance_alternatives_list.to_builder.target!
      else
        render json:{}, status: 404
      end
    end
  end

  def create
  end

  def search_similar_pauta
    # aqui se buscan para las variedades: benc o diesel, automatico, doble traccion
  end

  private

  def pauta_params
      params.require(:pauta).permit(:id_pauta)
  end
end
