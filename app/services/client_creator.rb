class ClientCreator < BaseService

  def call
    params[:rvm_id] = nil if params[:rvm_id] == Vehicle::DEFAULT_PATENT
    client = Client.find_or_create_by(email:params[:email], rvm_id: params[:rvm_id])
    client.update_attributes(params)
    if client
      send_registration_email
    end

    client
  end

  def send_registration_email
    # To DO
  end
end
