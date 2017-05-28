class HomeController < ApplicationController

  skip_before_action :set_default_vehicle, :only => [:search]

  def search
    session[:client] = nil
  end

end
