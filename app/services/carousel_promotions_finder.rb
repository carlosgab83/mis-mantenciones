# encoding: utf-8
require 'carousel/selector'

class CarouselPromotionsFinder < BaseService

  PROMOTIONS_TO_SHOW_IN_CAROUSEL = 20

  def call
    carousel_promotions(get_promotions_with_vmes + get_promotions_without_vmes, get_category_array)
  end

  private

  def carousel_promotions(promotions, category_circular_array)
    Carousel::Selector.new(size: PROMOTIONS_TO_SHOW_IN_CAROUSEL, objects: promotions, categories: category_circular_array).items
  end

  def get_promotions_base
    promotions = Promotion.availables.actives.with_stock.not_deleted
    .includes(:branches, :category)
    .joins(:promotions_vmes)
    .order("promotions.priority desc, promotions.promo_price asc, promotions.created_at desc")
    .limit(PROMOTIONS_TO_SHOW_IN_CAROUSEL)
  end

  def get_promotions_with_vmes
    promotions = []
    if params[:vehicle].present? and params[:vehicle].vme.present?
      promotions = get_promotions_base.where("(promotions_vmes.vme_id in (?))", params[:vehicle].vme.vme_id).to_a
    end
    promotions
  end

  def get_promotions_without_vmes
    promotions = get_promotions_base.where("promotions_vmes.vme_id IS NULL").to_a
  end

  def get_category_array
     [Category.roots.where(name: 'Productos').first, Category.roots.where(name: 'Vehículos').first, Category.roots.where(name: 'Servicios').first]
  end

end
