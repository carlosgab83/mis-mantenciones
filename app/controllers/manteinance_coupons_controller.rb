class ManteinanceCouponsController < ApplicationController
  #protect_from_forgery with: :exception

  # GET /manteinance_coupons/new?manteinance_coupon[id_pauta]=476
  def new
    if new_manteinance_coupon_params
      composer = ManteinanceAlternativesListComposer.new(new_manteinance_coupon_params)
      composer.active_sorting_button = params[:active_sorting_button]
      @manteinance_alternatives_list = composer.call
      EventTracker::OpenQuoteManteinanceCoupon.new(controller: self, vehicle: session[:vehicle], pauta: @manteinance_alternatives_list.pauta).track
      respond_to do |format|
        format.js { @manteinance_alternatives_list ? render(:new, status: :ok) : render( head :error)}
        return
      end
    end
  end

  def create
    if create_manteinance_coupon_params
      @manteinance_coupon = ManteinanceCouponsCreator.new(create_manteinance_coupon_params).call
      if @manteinance_coupon.valid?
        ManteinanceCouponsNotifier.new(manteinance_coupon: @manteinance_coupon, vehicle: session[:vehicle]).call
        respond_to do |format|
          format.js {render(:create, status: :ok)} # For Obtain coupon option
          format.html {render(:create, status: :ok)} # For Book option
          return
        end
      else
        render json: {error: I18n.t('general.error')}, status: 422
      end
    end
  end

  private

  def new_manteinance_coupon_params
    params.permit('active_sorting_button')
    params.require(:manteinance_coupon).permit(:id_pauta)
  end

  def create_manteinance_coupon_params
    params.require(:manteinance_coupon).permit(:pauta_id, :branch_id, :client_id)
  end
end
