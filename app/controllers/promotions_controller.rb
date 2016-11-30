class PromotionsController < ApplicationController
  protect_from_forgery with: :exception

  def index
    @promotions = AllPromotionsFinder.new(promotions_params).call
    @categories = Category.leaves
  end

  def show
    @promotion = PromotionDetail.new(params).call
  end

  private

  def promotions_params
    params.permit(:category_id)
  end
end
