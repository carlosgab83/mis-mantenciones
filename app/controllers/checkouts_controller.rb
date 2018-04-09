class CheckoutsController < ApplicationController

  def create
    prepare_checkout(checkout_params[:branch_id], checkout_params[:product_id], checkout_params[:promotion_id])

    respond_to do |format|
      format.html
    end
  end

  def show # direct URL to chekout: /checkout?product=product_slug&branch=branch_slug or /checkout?promotion=promotion_slug
    product = Product.friendly.find(params[:id]) rescue nil
    promotion = Promotion.friendly.find(params[:id]) rescue nil
    branch = Branch.friendly.find(params[:branch]) rescue nil

    EventTracker::UrlToCheckout.new(
      controller: self,
      vehicle: session[:vehicle],
      client: session[:client],
      product: product,
      promotion: promotion,
      branch: branch,
    ).track

    prepare_checkout(branch.try(:id), product.try(:id), promotion.try(:id))

    render :create
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

  def prepare_checkout(branch_id, product_id, promotion_id)
    @order_preparator = OrderPreparator.new(
      branch_id: branch_id,
      product_id: product_id,
      promotion_id: promotion_id,
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
  end
end
