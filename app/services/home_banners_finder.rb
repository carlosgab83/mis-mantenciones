# encoding: utf-8
class HomeBannersFinder < BaseService

  HOME_BANNERS_TO_SHOW_IN_CAROUSEL = 20

  def call
    HomeBanner.actives.availables.not_deleted.order(:priority, :id).limit(HOME_BANNERS_TO_SHOW_IN_CAROUSEL)
  end
end
