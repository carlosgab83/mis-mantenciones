class HomeController < ApplicationController
  protect_from_forgery with: :exception

  def search
  end

  # Testing patente: BLDR68
  def results
    session[:search] = {} if session[:search].nil?

    if params[:search].present?
      session[:search]['patent'] = params[:search][:patent]
      session[:search]['kms']    = params[:search][:kms]
    end

    if session[:search].nil? or session[:search]['patent'].nil? or session[:search]['kms'].nil?
      session[:rvm_id] = nil
      redirect_to :search_home
      return
    end

    begin
      @vehicle = VehicleFinder.new(SearchVehicleForm.new(session[:search])).call
      @pauta   = PautaFinder.new(vehicle: @vehicle).call
      session[:vehicle] = @vehicle
      @promotions = CarouselPromotionsFinder.new(vehicle: session[:vehicle]).call
      # Include here Promotions and Products
    rescue AppExceptions::PautaNotFound => e
      puts e.message
      puts e.backtrace
      redirect_to :search_home, flash: {error: I18n.t('home.pauta_not_found')}
      return
    end
  end
end
