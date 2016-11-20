class ProductsController < ApplicationController
  protect_from_forgery with: :exception

  def show
    @product = ProductDetail.new(params).call
  end
end
