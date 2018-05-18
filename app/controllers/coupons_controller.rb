class CouponsController < ApplicationController
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token

  def create
    if coupon_params
      @coupon = CouponsCreator.new(coupon_params).call
      if @coupon.valid?
        CouponsNotifier.new(coupon: @coupon, vehicle: session[:vehicle]).call
        EventTracker::ConfirmPromotion.new(controller: self, client: session[:client], vehicle: session[:vehicle], coupon: @coupon).track
        respond_to do |format|
          format.js {render(:create, status: :ok)}
          return
        end
      else
        render json: {error: I18n.t('general.error')}, status: 422
      end
    end
  end

  def derco
    client = ClientCreator.new(derco_client_params.merge({rvm_id: session[:vehicle].try(:patent)})).call
    derco_courpon_params = {promotion_id: params[:derco_client][:promotion_id], client_id: client.id}
    @coupon = CouponsCreator.new(derco_courpon_params).call
    if @coupon.valid?
      CouponsNotifier.new(coupon: @coupon, vehicle: session[:vehicle]).call
      EventTracker::ConfirmPromotion.new(controller: self, client: session[:client], vehicle: session[:vehicle], coupon: @coupon).track
      redirect_to root_path
    end
  end


  private

  def coupon_params
    params.require(:coupon).permit(:promotion_id, :client_id)
  end

  def derco_client_params
    params.require(:derco_client).permit(:name, :email, :phone, :comune_id, :manteinance_type, :brand, :message)
  end
end
