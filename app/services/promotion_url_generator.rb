# encoding: utf-8

class PromotionUrlGenerator < BaseService

  def call
    url_generator
  end

  private

  def url_generator
     Rails.application.routes.url_helpers.promotion_url(params[:promotion], patent: params[:patent], kms: params[:kms], host: base_host)
  end

end
