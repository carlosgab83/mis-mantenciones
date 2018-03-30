# encoding: utf-8

class PaymentResultsProcessor < BaseService

  attr_reader :payment, :vehicle, :normal_flow

  def call
    self.payment = params[:payment]
    self.vehicle = params[:vehicle]
    return false unless payment
    payment.reload
    case payment.status
      when 'completed'
        true
      when 'semi_completed'
        process_success
      when 'cancelled'
        false
      when 'pending'
        process_pending
      else
        false
    end
  end

  def transaction_datetime
    @transaction_datetime ||= -> {
      xml = Nokogiri::XML(payment.extra_data)
      DateTime.parse xml.at_xpath("//transactiondate").text
    }.call
  end

  private

  attr_writer :payment, :transaction_datetime, :vehicle, :normal_flow

  def process_success
    payment.status = :completed
    payment.save
    payment.order.status = :completed
    payment.order.save
    self.normal_flow = true
    SuccessPaymentNotifier.new(payment: payment, vehicle: vehicle).call
    true
  end

  def process_pending
    webpay_data = nil
    begin
      payment.status = :cancelled
      payment.order.status = :cancelled
      webpay_data = PaymentsGateway::Webpay::Normal::Transaction.new.confirm(payment.token)
      payment.extra_data = webpay_data
    rescue Savon::SOAPFault => e
      Rails.logger.info "Webpay transaction response: Exception, message: #{e.message}"
      payment.extra_data = e.message
    end
    payment.save
    payment.order.save
    false
  end
end
