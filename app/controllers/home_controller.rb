class HomeController < ApplicationController
  protect_from_forgery with: :exception

  def search
  end

  def results
    session[:search] = {} unless session[:search].present?

    if params[:search].present?
      session[:search]['patente'] = params[:search][:patente]
      session[:search]['kms']     = params[:search][:kms]
    end

    if session[:search].nil? or session[:search]['patente'].nil? or session[:search]['kms'].nil?
      redirect_to :search_home
    end

  end
end
