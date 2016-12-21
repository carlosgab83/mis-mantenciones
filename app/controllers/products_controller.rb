class ProductsController < ApplicationController
  protect_from_forgery with: :exception

  def show
    @product = ProductDetail.new(params).call
    EventTracker::OpenProduct.new(controller: self, vehicle: session[:vehicle], client: session[:client], product: @product).track
  end
end
