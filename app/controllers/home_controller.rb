class HomeController < ApplicationController

  skip_before_action :set_default_vehicle, :only => [:search]

  def search
    session[:client] = nil
    render action: :results
  end

  # Testing patente: BLDR68 # PASSAT
  # Testing patente: RK1478 # GOLF
  # Testing patente: BYKP82 # BORA
  def results
    if session[:search].nil?
      session[:search] = {}
    end

    if params[:search].present?
      session[:search]['location'] = params[:search][:location]
      session[:search]['latitude'] = params[:search][:latitude]
      session[:search]['longitude'] = params[:search][:longitude]
    end

    if session[:search]['location'].nil? or session[:search]['location'].blank?
      EventTracker::ClickSearchWithoutLocation.new(controller: self).track
    end

    # TODO: Search with location | Latitude | Longitude ...

    # TODO: Track event:
    # EventTracker::ClickSeachWithLocation.new(
    #   controller: self,
    #   location: session[:search]['location'],
    #   latitude: session[:search]['location'],
    #   longitude: session[:search]['longitude']
    # ).track
  end
end
