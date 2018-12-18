class WebpayController < ApplicationController
  layout false

  def confirmation
    raise unless params[:token_ws]
    @webpay_data = PaymentsGateway::Webpay::Normal::Transaction.new.confirm(params[:token_ws])

    if (payment = Payment.where(token: params[:token_ws]).first)
      response_code = @webpay_data.xpath("//responsecode").first.try(:text)
      case response_code
        when '0'
          payment.status = :semi_completed
          payment.order.status = :semi_completed
          payment.extra_data = @webpay_data
        else
          payment.status = :cancelled
          payment.order.status = :cancelled
          payment.extra_data = @webpay_data
      end

      payment.save
      payment.order.save
    end

    @redirection_url = @webpay_data.xpath("//urlredirection").first.try(:text)
    response = Net::HTTP.post_form(URI(@redirection_url), token_ws: params[:token_ws])
    if response.code.to_i == 200
      respond_to do |format|
        format.html
      end
      return
    end
    return
  end
end
