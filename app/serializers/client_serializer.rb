module ClientSerializer
  def to_event_tracker_builder
    Jbuilder.new do |json|
      json.client_id                 id
      json.client_name               name
      json.client_primary_last_name  primary_last_name
      json.client_email              email
      json.client_phone              phone
      json.client_rut                rut
      json.client_street_address     street_address
      json.client_number_address     number_address
      json.client_comune_id          comune_id
    end
  end
end