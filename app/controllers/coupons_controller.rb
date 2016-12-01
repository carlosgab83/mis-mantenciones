class CouponsController < ApplicationController
  protect_from_forgery with: :exception
  skip_before_filter  :verify_authenticity_token

  def create
    if coupon_params
      @coupon = CouponsCreator.new(coupon_params).call
      if @coupon
        CouponsNotifier.new(coupon: @coupon).call
        respond_to do |format|
          format.js {render(:create, status: :ok)}
          return
        end
      else
        render json: {error: I18n.t('general.error')}, status: 422
      end
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:promotion_id, :client_id)
  end
end
