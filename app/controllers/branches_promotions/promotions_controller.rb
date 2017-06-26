module BranchesPromotions
  class PromotionsController < ApplicationController
    protect_from_forgery with: :exception

    before_filter :shop, only: [:index, :show]
    before_filter :branch, only: [:index, :show]
    before_filter :promotion, only: [:show]

    def index
      @promotions = BranchesPromotionsFinder.new(branch_params).call
      @categories = PromotionCategoriesFinder.new(branch: branch).call
      render '/promotions/index'
    end

    def show
      if promotion
        EventTracker::OpenPromotion.new(controller: self, client: session[:client], vehicle: session[:vehicle], promotion: promotion).track
        render '/promotions/show', id: promotion.slug
      else
        render '/promotions/index'
      end
    end

    private

    def shop
      @shop ||= branch.shop
    end

    def branch
      @branch ||= Branch.includes(:shop).friendly.find(params[:branch_id])
    end

    def promotion
      @promotion ||= PromotionDetail.new(params).call
    end

    def branch_params
      params.permit(:branch_id, :category_id)
    end
  end
end
