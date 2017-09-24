class HomeController < ApplicationController

  skip_before_action :set_default_vehicle, :only => [:search, :my_pauta]

  def search
    session[:client] = nil
    session[:search_branches_params] = nil
  end

  def my_pauta
    session[:client] = nil
    session[:search_branches_params] = nil
  end

  # Testing patente: BLDR68 # PASSAT
  # Testing patente: RK1478 # GOLF
  # Testing patente: BYKP82 # BORA
  def results
    fill_session

    if session[:search]['patent'].nil? or session[:search]['patent'].blank?
      EventTracker::ClickSearchWithoutPatent.new(controller: self).track
    end

    begin
      @vehicle = VehicleFinder.new(SearchVehicleForm.new(session[:search])).call
      # If not vehicle found, @vehicle.vme is nil
      @pauta   = PautaFinder.new(vehicle: @vehicle).call
      session[:vehicle] = @vehicle
      @promotions = CarouselPromotionsFinder.new(vehicle: session[:vehicle]).call
      @products   = CarouselProductsFinder.new(vehicle: session[:vehicle]).call

      EventTracker::SearchPatent.new(controller: self, vehicle: @vehicle, pauta: @pauta, promotions: @promotions, products: @products).track
    rescue AppExceptions::PautaNotFound => e
      puts e.message
      puts e.backtrace
      render :results, flash: {error: I18n.t('home.pauta_not_found')}
      return
    end
  end

  private

  def fill_session
    session[:search] = {} if session[:search].nil?
    if params[:search].present?
      session[:search]['patent'] = params[:search][:patent]
      session[:search]['kms']    = params[:search][:kms]
    end
  end

end
