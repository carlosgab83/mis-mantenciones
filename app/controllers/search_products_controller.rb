class SearchProductsController < ApplicationController
  include ModelSelector

  # When calling this controller without any category
  # Simply redirect to show with first root category
  def index
    EventTracker::SearchProducts.new(controller: self, vehicle: session[:vehicle], client: session[:client], category: nil).track
    default_category = Category.where(name: 'Neumáticos').first || Category.roots.first
    redirect_to action: :show, id: default_category.try(:slug)
  end

  # Shows initial view
  def show
    @category = Category.friendly.find(params[:id]) || Category.roots.first.slug # i.e: /search_products/neumaticos

    @search_products_form = ProductsFinder.new(client_search_input: params[:client_search_input], category: @category, vehicle: session[:vehicle]).call
    @products = @search_products_form.results
    EventTracker::SearchProducts.new(controller: self, vehicle: session[:vehicle], client: session[:client], category: @category, client_search_input: params[:client_search_input]).track
  end

  # Make new search based on user criteria
  def update
    show
    render action: :show
  end
end
