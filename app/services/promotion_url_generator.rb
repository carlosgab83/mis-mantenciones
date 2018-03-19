# encoding: utf-8

class PromotionUrlGenerator < BaseService

  def call
    url_generator
  end

  private

  def url_generator
    Rails.application.routes.url_helpers.shop_branch_promotion_url(
      params[:promotion].first_shop.slug,
      params[:promotion].first_branch.slug,
      params[:promotion].slug,
      patent: params[:patent],
      kms: params[:kms],
      host: base_host
    )
  end

end
