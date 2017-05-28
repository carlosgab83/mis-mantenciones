class SearchBranchesController < ApplicationController

  before_action :search_branches_form, only: [:create]

  # Make new search based on user criteria
  def create
    @branches = BranchesFinder.new(form: search_branches_form).call

    respond_to do |format|
      format.js
    end

    # TODO: Track event:
    # EventTracker::ClickSeachWithLocation.new(
    #   controller: self,
    #   location: session[:search]['location'],
    #   latitude: session[:search]['location'],
    #   longitude: session[:search]['longitude']
    # ).track
  end

  def model_collection
    @models = Model.actives.where(id_marca: params[:brand_id]).order(:modelo_descripcion)
    respond_to do |format|
      format.js
    end
  end

  private

  def search_branches_form
    @search_branches_form ||= SearchBranchesForm.new(params[:search]  || {})
  end

end
