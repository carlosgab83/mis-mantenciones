# encoding: utf-8

class BranchInformationCarouselCreator < BaseService

  def call
    BranchPlanManager::Base.new(branch: params[:branch]).branch_plan_instance.branch_information_carousel_promotions
  end
end
