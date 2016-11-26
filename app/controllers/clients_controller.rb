class ClientsController < ApplicationController
  protect_from_forgery with: :exception

    def new
      @client = Client.new
      respond_to do |format|
        format.js { params[:partial] ? render(:new, status: :ok) : render( head :error)}
        return
      end
    end

    def create
    if create_client_params
      client = ClientCreator.new(create_client_params.merge({rvm_id: session[:vehicle].try(:patent)})).call
      if client
        render json: client, status: 201
      else
        render json: {error: I18n.t('general.error')}, status: 422
      end
    end
  end

  private

  def new_client_params
    params.permit(:partial)
  end

  def create_client_params
    params.require(:client).permit(:name, :primary_last_name, :email, :phone, :rut, :comune_id)
  end
end
