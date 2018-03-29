# encoding: utf-8

class PaymentResultsProcessor < BaseService

  attr_reader :payment, :transaction_datetime, :vehicle

  def call
    self.payment = params[:payment]
    self.vehicle = params[:vehicle]
    return false unless payment
    case payment.status
      when 'semi_completed', 'completed'
        process_success
      when 'cancelled'
        false
      when 'pending'
        process_pending
      else
        false
    end
  end

  private

  attr_writer :payment, :transaction_datetime, :vehicle

  def process_success
    xml = Nokogiri::XML(payment.extra_data)
    self.transaction_datetime = DateTime.parse xml.at_xpath("//transactiondate").text

    if payment.status == 'semi_completed'
      SuccessPaymentNotifier.new(payment: payment, vehicle: vehicle).call
      payment.status = :completed
      payment.save
      payment.order.status = :completed
      payment.order.save
    end
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
