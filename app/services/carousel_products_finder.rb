# encoding: utf-8
require 'carousel/selector'

class CarouselProductsFinder < BaseService

  PRODUCTS_TO_SHOW_IN_CAROUSEL = 20

  def call
    carousel_products(get_products, get_category_array)
  end

  private

  def carousel_products(products, category_circular_array)
    Carousel::Selector.new(size: PRODUCTS_TO_SHOW_IN_CAROUSEL, objects: products, categories: category_circular_array).items
  end

  def get_products
    products = Product.not_deleted
    .includes(:branches, :category)
    .joins(:products_vmes)
    .order("products.created_at desc")
    if params[:vehicle].present? and params[:vehicle].vme.present?
      products = products.where("(products_vmes.vme_id in (?) or products_vmes.vme_id IS NULL)", params[:vehicle].vme.vme_id)
    else
      products = products.where("products_vmes.vme_id IS NULL")
    end
  end

  def get_category_array
     [Category.roots.where(name: 'Producto').first]
  end

end
