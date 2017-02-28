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
    if params[:client_search_input].try(:[],'horizontal_filters').try(:[],'by_vehicle').present? or params[:client_search_input].nil?
      params[:client_search_input] = {'horizontal_filters' => {'by_vehicle'=>{}}} if params[:client_search_input].nil?
      if ((params[:client_search_input]['horizontal_filters']['by_vehicle'].values||[]) - [""]).empty?
        params[:client_search_input]['horizontal_filters']['by_vehicle']['brand_id'] = session[:vehicle].brand_id
        params[:client_search_input]['horizontal_filters']['by_vehicle']['model_id'] = session[:vehicle].model_id
        params[:client_search_input]['horizontal_filters']['by_vehicle']['year'] = session[:vehicle].manufacturing_year
      end
    end

    @search_products_form = ProductsFinder.new(client_search_input: params[:client_search_input], category: @category, vehicle: session[:vehicle]).call
    @products = @search_products_form.results
    EventTracker::SearchProducts.new(controller: self, vehicle: session[:vehicle], client: session[:client], category: @category, client_search_input: params[:client_search_input]).track
  end

  # Make new search based on user criteria
  def update
    show
    render action: :show
  end

  def model_collection
    @models = Model.actives.where(id_marca: params[:brand_id]).order(:modelo_descripcion)
    respond_to do |format|
      format.js
    end
  end
end
