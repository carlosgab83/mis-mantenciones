module ClientSerializer
  def to_event_tracker_builder
    Jbuilder.new do |json|
      json.client_id                 id
      json.client_name               name
      json.client_primary_last_name  primary_last_name
      json.client_email              email
    end
  end
end