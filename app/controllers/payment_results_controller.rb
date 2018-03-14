class PaymentResultsController < ApplicationController
  # NEEDS REFACTOR: Too many if's statements
  def create
    @payment = Payment.where(token: params[:token_ws]).first

    if @payment
      EventTracker::PaymentResult.new(
        controller: self,
        vehicle: session[:vehicle],
        payment: @payment
      ).track
    end

    if @payment and @payment.status == 'completed'
      xml = Nokogiri::XML(@payment.extra_data)
      @transaction_datetime = DateTime.parse xml.at_xpath("//transactiondate").text

      SuccessPaymentNotifier.new(payment: @payment, vehicle: session[:vehicle]).call

      render :success

    elsif @payment and @payment.status == 'cancelled' # i.e Transaction rejected
      render :fail

    elsif @payment.nil?
      payment = Payment.where(token: params["TBK_TOKEN"]).first
      webpay_data = nil
      begin
        webpay_data = PaymentsGateway::Webpay::Normal::Transaction.new.confirm(params["TBK_TOKEN"])
        payment.extra_data = webpay_data
      rescue Savon::SOAPFault => e
        Rails.logger.info "Webpay transaction response: Exception, message: #{e.message}"
        payment.extra_data = e.message
      end
      payment.save
      render :fail

    else # Must never enter here
      render :fail
    end
  end

end
