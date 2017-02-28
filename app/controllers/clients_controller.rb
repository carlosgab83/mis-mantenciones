class ClientsController < ApplicationController
  protect_from_forgery with: :exception

    def new
      @client = session[:client] || Client.new
      session[:last_context] = params
      respond_to do |format|
        format.js { params[:partial] ? render(:new, status: :ok) : render( head :error)}
        return
      end
    end

    def create
    if create_client_params
      client = ClientCreator.new(create_client_params.merge({rvm_id: session[:vehicle].try(:patent)})).call
      if client.valid?
        @context_params = session[:last_context]
        @context_params[:client_id] = client.id
        session[:last_context] = nil
        session[:client] = client
        EventTracker::RegisterAsClient.new(controller: self, vehicle: session[:vehicle], client: client, by: params[:success_partial]).track
        render partial: params[:success_partial]
      else
        render action: :fail, status: 422
      end
    end
  end

  def update
    create
  end

  private

  def new_client_params
    params.permit(:partial)
  end

  def create_client_params
    params.require(:client).permit(:name, :email, :phone)
  end
end
