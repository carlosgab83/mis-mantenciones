class SearchProductsController < ApplicationController

  # Follow Pattern Only CRUD Controllers

  # When calling this controller without any category
  # Simply redirect to show with first root category
  def index
    EventTracker::SearchProducts.new(controller: self, vehicle: session[:vehicle], client: session[:client], category: nil).track
    default_category = Category.where(name: 'Neumáticos').first || Category.roots.first
    redirect_to action: :show, id: default_category.try(:name)
  end

  # Shows initial view
  def show
    @category = Category.where(name: params[:id]).first || Category.roots.first.id # i.e: /search_products/neumaticos
    @products = []
    @search_products_form = ProductsFinder.new(client_search_input: params[:client_search_input], category: @category, vehicle: session[:vehicle]).call
    EventTracker::SearchProducts.new(controller: self, vehicle: session[:vehicle], client: session[:client], category: @category).track
  end

  # Make new search based on user criteria
  def new
  end
end
