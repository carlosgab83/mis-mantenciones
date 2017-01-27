class ApplicationController < ActionController::Base
  protect_from_forgery with: :reset_session

  before_filter :assign_url_patent

  # For clicking from email
  def assign_url_patent
    if params[:patent].present?
      session[:vehicle] = VehicleFinder.new(SearchVehicleForm.new('patent' => params[:patent], 'kms' => params[:kms])).call
    end
  end
end
