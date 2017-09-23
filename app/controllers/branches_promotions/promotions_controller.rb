module BranchesPromotions
  class PromotionsController < ApplicationController
    protect_from_forgery with: :exception

    before_action :shop, only: [:index, :show]
    before_action :branch, only: [:index, :show]
    before_action :promotion, only: [:show]

    def index
      @promotions = BranchesPromotionsFinder.new(branch_params).call
      @categories = PromotionCategoriesFinder.new(branch: branch).call
      EventTracker::OpenAllPromotions.new(
        controller: self,
        client: session[:client],
        vehicle: session[:vehicle],
        branch: branch,
        event: 'Open All Promotions for branch'
      ).track

      render '/promotions/index'
    end

    def show
      if promotion
        EventTracker::OpenPromotion.new(controller: self, client: session[:client], vehicle: session[:vehicle], promotion: promotion).track
        if promotion.is_a? BranchInformation
          render '/promotions/show_branch_information', id: promotion.slug
        else
          render '/promotions/show', id: promotion.slug
        end
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
