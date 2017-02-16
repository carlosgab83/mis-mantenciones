class ApplicationController < ActionController::Base
  protect_from_forgery with: :reset_session

  before_action :assign_url_patent, :set_default_vehicle

  # For clicking from email
  def assign_url_patent
    if params[:patent].present?
      session[:vehicle] = VehicleFinder.new(SearchVehicleForm.new('patent' => params[:patent], 'kms' => params[:kms])).call
    end
  end

  def set_default_vehicle
    if session[:vehicle].nil?
      session[:vehicle] = VehicleFinder.new(SearchVehicleForm.new('patent' => '', 'kms' => '')).call
      @vehicle = session[:vehicle]
    end
  end
end
