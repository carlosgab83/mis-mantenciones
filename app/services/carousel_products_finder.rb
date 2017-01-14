# encoding: utf-8
require 'carousel/selector'

class CarouselProductsFinder < BaseService

  PRODUCTS_TO_SHOW_IN_CAROUSEL = 20

  def call
    carousel_products(get_products_with_vmes + get_products_without_vmes, get_category_array)
  end

  private

  def carousel_products(products, category_circular_array)
    Carousel::Selector.new(size: PRODUCTS_TO_SHOW_IN_CAROUSEL, objects: products, categories: category_circular_array).items
  end

  def get_products_base
    products = Product.actives.not_deleted
    .includes(:branches, :category)
    .joins(:products_vmes)
    .order("products.created_at desc")
    .limit(PRODUCTS_TO_SHOW_IN_CAROUSEL)
  end

  def get_products_with_vmes
    products = []
    if params[:vehicle].present? and params[:vehicle].vme.present?
      products = get_products_base.where("(products_vmes.vme_id in (?))", params[:vehicle].vme.vme_id).to_a
    end
    products
  end

  def get_products_without_vmes
    products = get_products_base.where("products_vmes.vme_id IS NULL").to_a
  end

  def get_category_array
     [Category.roots.where(name: 'Productos').first]
  end

end
