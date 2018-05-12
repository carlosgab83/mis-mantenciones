class OrdersController < ApplicationController

  def create
   order_creator = OrderCreator.new(order_params.merge(buyables: [params[:order][:buyable]])).call
   session_id = "#{order_creator.client.id}-#{order_creator.order.id}"

   EventTracker::ClickToPay.new(
      controller: self,
      vehicle: session[:vehicle],
      order: order_creator.order,
      payment_type: params[:order][:payment_type]
    ).track

   @webpay_data = PaymentsGateway::Webpay::Normal::Transaction.new.initiate(
      order_creator.cart.price,
      session_id,
      order_creator.order.order_number
    )

   PaymentCreator.new(order_data: order_creator, webpay_data: @webpay_data, session_id: session_id).call

    puts "///////////////////////"
    puts @webpay_data[:token]

    respond_to do |format|
      format.html
    end
  end

  private

  def order_params
    params.require(:order)
    .permit(
      :email, :rut, :name, :primary_last_name, :phone,
      :street_address, :number_address, :region, :commune_id,
      :contact_seller, :contact_phone, :accept_terms,
      :payment_type, :retirement_type, :branch_installation,
      :delivery_installation, :retirement_branch
    )
  end
end
