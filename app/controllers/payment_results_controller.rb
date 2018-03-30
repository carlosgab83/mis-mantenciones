class PaymentResultsController < ApplicationController
  def create
    @payment = Payment.where(token: params[:token_ws]).first || Payment.where(token: params["TBK_TOKEN"]).first # later is when is error

    service = PaymentResultsProcessor.new(payment: @payment, vehicle: session[:vehicle])
    success = service.call

    if service.normal_flow
      EventTracker::PaymentResult.new(
        controller: self,
        vehicle: session[:vehicle],
        payment: @payment
      ).track
    end

    if success
      @transaction_datetime = service.transaction_datetime
      render :success
    else
      render :fail
    end
  end
end
