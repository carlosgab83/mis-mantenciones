# encoding: utf-8
require 'carousel/selector'

class CarouselPromotionsFinder < BaseService

  PROMOTIONS_TO_SHOW_IN_CAROUSEL = 20

  def call
    carousel_promotions(
      get_promotions_with_vmes_with_year +
      get_promotions_without_vmes_without_year,
      get_category_array
    )
  end

  private

  def carousel_promotions(promotions, category_circular_array)
    Carousel::Selector.new(size: PROMOTIONS_TO_SHOW_IN_CAROUSEL, objects: promotions, categories: category_circular_array).items
  end

  def get_promotions_base
    OtherPromotion.availables.actives.with_stock.not_deleted.not_blog
    .includes(:branches, :category)
    .order("promotions.priority desc, promotions.promo_price asc, promotions.created_at desc")
    .limit(PROMOTIONS_TO_SHOW_IN_CAROUSEL)
  end

  def get_promotions_with_vmes_with_year
    promotions = []
    if params[:vehicle].present? and params[:vehicle].vme.present? and params[:vehicle].manufacturing_year.present?
      promotions = get_promotions_base.joins(:promotions_vmes).where(
        "promotions_vmes.vme_id in (?) and (
          '?' between promotions_vmes.from_year and promotions_vmes.to_year or
          '?' > promotions_vmes.from_year or
          '?' < promotions_vmes.to_year
        )",
        params[:vehicle].vme.vme_id,
        params[:vehicle].manufacturing_year.to_i,
        params[:vehicle].manufacturing_year.to_i,
        params[:vehicle].manufacturing_year.to_i
      ).to_a
    end
    promotions
  end

  def get_promotions_without_vmes_without_year
    get_promotions_base.to_a
  end

  def get_category_array
    [Category.roots.where(name: 'Productos').first, Category.roots.where(name: 'Vehículos').first, Category.roots.where(name: 'Servicios').first]
  end

end
