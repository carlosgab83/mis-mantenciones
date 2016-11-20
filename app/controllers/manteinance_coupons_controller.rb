class ManteinanceCouponsController < ApplicationController
  protect_from_forgery with: :exception
  skip_before_filter  :verify_authenticity_token

  # GET /manteinance_coupons/new?manteinance_coupon[id_pauta]=476
  def new
    if new_manteinance_coupon_params
      manteinance_alternatives_list = ManteinanceAlternativesListComposer.new(new_manteinance_coupon_params).call
      if manteinance_alternatives_list
        render json: manteinance_alternatives_list.to_builder.target!
      else
        render json:{}, status: 404
      end
    end
  end

  def create
    if create_manteinance_coupon_params
      manteinance_coupon = ManteinanceCouponsCreator.new(create_manteinance_coupon_params).call
      if manteinance_coupon
        render json: manteinance_coupon, status: 201
      else
        render json: {error: I18n.t('general.error')}, status: 422
      end
    end
  end

  private

  def new_manteinance_coupon_params
    params.require(:manteinance_coupon).permit(:id_pauta)
  end

  def create_manteinance_coupon_params
    params.require(:manteinance_coupon).permit(:id_pauta, :branch_id, :client_id)
  end
end
