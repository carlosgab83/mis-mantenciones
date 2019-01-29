class PromotionsController < ApplicationController
  protect_from_forgery with: :exception

  def index
    @promotions = PromotionsFinder.new(promotions_params).call
    @categories = PromotionCategoriesFinder.new.call
    common_render(promotions_params)
    return
  end

  def blog
    category_id = Category.where(slug: 'blog').first.try(:id)
    @categories = []
    @promotions = PromotionsFinder.new(promotions_params).blog_call
    common_render(category_id: category_id)
  end

  private

  def promotions_params
    category_id = params[:category].present? ? Category.find_by_slug(params[:category]).try(:id) : nil
    params[:category_id] = category_id || params[:category_id]
    params
  end

  def common_render(promotions_params)
    if promotions_params[:category_id].present?
      category = Category.find(promotions_params[:category_id])
      EventTracker::FilterPromotions.new(controller: self, client: session[:client], vehicle: session[:vehicle], category: category).track
    else
      EventTracker::OpenAllPromotions.new(controller: self, client: session[:client], vehicle: session[:vehicle]).track
    end
    render action: :index
  end
end
