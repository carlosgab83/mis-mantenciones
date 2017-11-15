class WebpayController < ApplicationController
  layout false

  def confirmation
    raise unless params[:token_ws]
    @webpay_data = PaymentsGateway::Webpay::Normal::Transaction.new.confirm(params[:token_ws])
    @redirection_url = @webpay_data.xpath("//urlredirection").first.try(:text)
    response = Net::HTTP.post_form(URI(@redirection_url), token_ws: params[:token_ws])
    if response.code.to_i == 200
      respond_to do |format|
        format.html { render text: response.body.html_safe }
      end
      return
    end
    return
  end

  def final
    render text: "Completado: #{params.to_json} <a href='/'>Go to home</a>, <a href='/pay_test'>Go to pay again</a>", layout: false
  end
end