module OrderSerializer
  def to_event_tracker_builder
    Jbuilder.new do |json|
      json.client_id           client.id
      json.contact_seller      contact_seller
      json.full_name           full_name
      json.contact_phone       contact_phone
      json.accept_terms        accept_terms
      json.cart_id             cart.id
      json.branch_id           branch.id
    end
  end
end