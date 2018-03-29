class PaymentResultsController < ApplicationController
  # NEEDS REFACTOR: Too many if's statements
  def create

    @payment = Payment.where(token: params[:token_ws]).first || Payment.where(token: params["TBK_TOKEN"]).first # later is error

    service = PaymentResultsProcessor.new(payment: @payment)
    success = service.call

    if @payment
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


    # @payment = Payment.where(token: params[:token_ws]).first

    # if @payment
    #   EventTracker::PaymentResult.new(
    #     controller: self,
    #     vehicle: session[:vehicle],
    #     payment: @payment
    #   ).track
    # end

    # if @payment and (@payment.status == 'semi_completed' or @payment.status == 'completed')
    #   xml = Nokogiri::XML(@payment.extra_data)
    #   @transaction_datetime = DateTime.parse xml.at_xpath("//transactiondate").text

    #   if @payment.status == 'semi_completed'
    #     SuccessPaymentNotifier.new(payment: @payment, vehicle: session[:vehicle]).call

    #     @payment.status = :completed
    #     @payment.save

    #     @payment.order.status = :completed
    #     @payment.order.save
    #   end

    #   render :success

    # elsif @payment and @payment.status == 'cancelled' # i.e Transaction rejected
    #   render :fail

    # elsif @payment.nil?
    #   payment = Payment.where(token: params["TBK_TOKEN"]).first
    #   webpay_data = nil
    #   if payment
    #     begin
    #       payment.status = :cancelled
    #       payment.order.status = :cancelled
    #       webpay_data = PaymentsGateway::Webpay::Normal::Transaction.new.confirm(params["TBK_TOKEN"])
    #       payment.extra_data = webpay_data
    #     rescue Savon::SOAPFault => e
    #       Rails.logger.info "Webpay transaction response: Exception, message: #{e.message}"
    #       payment.extra_data = e.message
    #     end
    #     payment.save
    #     payment.order.save
    #     render :fail
    #   else
    #     render :fail
    #   end
    # else # Must never enter here
    #   render :fail
    # end
  end

end
