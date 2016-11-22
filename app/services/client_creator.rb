class ClientCreator < BaseService

  def call
    client = Client.create(params)
    if client
      send_registration_email
    end

    client
  end

  def send_registration_email
    # To DO
  end
end
