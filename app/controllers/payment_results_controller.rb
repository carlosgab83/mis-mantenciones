class PaymentResultsController < ApplicationController

  def create
    payment = Payment.where(token: params[:token_ws]).first
    if payment and payment.status == 'completed'
      render :success
    else
      render :fail
    end
  end

end
