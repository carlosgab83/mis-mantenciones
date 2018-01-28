class PaymentCreator < BaseService

  attr_reader :payment

  def call
    self.payment = create_payment
  end

  private

  attr_writer :payment

  def create_payment
    Payment.create(
      amount: params[:order_data].cart.price,
      session_id: params[:session_id],
      token: params[:webpay_data][:token],
      status: :pending,
      order_id: params[:order_data].order.id,
    )
  end
end
