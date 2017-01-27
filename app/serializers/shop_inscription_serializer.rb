module ShopInscriptionSerializer
  def to_event_tracker_builder
    Jbuilder.new do |json|
      json.client_id                 id
      json.client_name               name
      json.client_primary_last_name  primary_last_name
      json.client_email              email
      json.client_company_name       company_name
      json.client_company_rut        company_rut
    end
  end
end