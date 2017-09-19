class FrontendTrackingController < ApplicationController
  protect_from_forgery with: :exception

  def create
    EventTracker::FrontendTracking.new(
      controller: self,
      client: session[:client],
      data: (params[:data] == '' ? {} : params[:data]),
      event: params[:event]
    ).track

    head :ok
  end
end
