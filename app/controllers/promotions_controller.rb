class PromotionsController < ApplicationController
  protect_from_forgery with: :exception

  def index
    @promotions = AllPromotionsFinder.new(promotions_params).call
    @categories = Category.leaves
    if promotions_params[:category_id].present?
      category = Category.find(promotions_params[:category_id])
      EventTracker::FilterPromotions.new(controller: self, client: session[:client], vehicle: session[:vehicle], category: category).track
    else
      EventTracker::OpenAllPromotions.new(controller: self, client: session[:client], vehicle: session[:vehicle]).track
    end
  end

  def show
    @promotion = PromotionDetail.new(params).call
    if @promotion
      EventTracker::OpenPromotion.new(controller: self, client: session[:client], vehicle: session[:vehicle], promotion: @promotion).track
    else
      redirect_to :promotions
    end
  end

  private

  def promotions_params
    params.permit(:category_id)
  end
end
