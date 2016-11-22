class PromotionsController < ApplicationController
  protect_from_forgery with: :exception

  def index
    @promotions = AllPromotionsFinder.new.call
    @categories = Category.leaves
  end

  def show
    @promotion = PromotionDetail.new(params).call
  end
end
