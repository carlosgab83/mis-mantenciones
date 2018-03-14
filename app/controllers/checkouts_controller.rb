class CheckoutsController < ApplicationController

  def create
    @order_preparator = OrderPreparator.new(
      branch_id: checkout_params[:branch_id],
      product_id: checkout_params[:product_id],
      promotion_id: checkout_params[:promotion_id],
      client: session[:client],
    ).call

    EventTracker::OpenCheckout.new(
      controller: self,
      vehicle: session[:vehicle],
      client: @order_preparator.client,
      product: @order_preparator.product,
      promotion: @order_preparator.promotion,
      branch: @order_preparator.branch,
      price: @order_preparator.buyable_tupple_record.price
    ).track

    respond_to do |format|
      format.html
    end
  end

  def update_price_by_quantity
    @price = params[:price].to_f * params[:quantity].to_i

    respond_to do |format|
      format.js
    end
  end

  private

  def checkout_params
    params.require(:checkout).permit(:branch_id, :product_id, :promotion_id)
  end
end
