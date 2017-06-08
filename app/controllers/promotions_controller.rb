class PromotionsController < ApplicationController
  protect_from_forgery with: :exception

  def index
    @promotions = PromotionsFinder.new(promotions_params).call
    @categories = PromotionCategoriesFinder.new.call
    if promotions_params[:category_id].present?
      category = Category.find(promotions_params[:category_id])
      EventTracker::FilterPromotions.new(controller: self, client: session[:client], vehicle: session[:vehicle], category: category).track
    else
      EventTracker::OpenAllPromotions.new(controller: self, client: session[:client], vehicle: session[:vehicle]).track
    end
  end

  private

  def promotions_params
    params.permit(:category_id)
  end
end
