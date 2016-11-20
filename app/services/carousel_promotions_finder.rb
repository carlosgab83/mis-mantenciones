# encoding: utf-8
require 'carousel/selector'

class CarouselPromotionsFinder < BaseService

  PROMOTIONS_TO_SHOW_IN_CAROUSEL = 20

  def call
    carousel_promotions(get_promotions, get_category_array)
  end

  private

  def carousel_promotions(promotions, category_circular_array)
    Carousel::Selector.new(size: PROMOTIONS_TO_SHOW_IN_CAROUSEL, objects: promotions, categories: category_circular_array).items
  end

  def get_promotions
    Promotion.availables.actives.with_stock.not_deleted
    .includes(:branches, :category)
    .joins(:promotions_vmes)
    .where("(promotions_vmes.vme_id in (?) or promotions_vmes.vme_id IS NULL)", params[:vehicle].vme.try(:vme_id))
    .order("promotions.created_at desc, promotions.promo_price asc")
  end

  def get_category_array
     [Category.roots.where(name: 'Producto').first, Category.roots.where(name: 'Vehículo').first, Category.roots.where(name: 'Servicio').first]
  end

end
