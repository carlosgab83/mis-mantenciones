class ManteinanceCouponsController < ApplicationController
  protect_from_forgery with: :exception

  def new
    # params[:pauta_id]
    # # get generic pauta
    # # get each branches pauta
    # {
    #   generic_manteinance_items:[
    #     {id:, name:} # Id y name de item_mantencion
    #   ],
    #   branches_pautas:[
    #     {
    #       id,
    #       name,
    #       total_price,
    #       manteinance_items:[
    #         {id:, name:} # Id y name de item_mantencion
    #       ]
    #     }
    #   ]
    # }
  end

  def create
  end

  def search_similar_pauta
    # aqui se buscan para las variedades: benc o diesel, automatico, doble traccion
  end
end
