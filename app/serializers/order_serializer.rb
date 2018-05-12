module OrderSerializer
  def to_event_tracker_builder
    Jbuilder.new do |json|
      json.client_id              client.id
      json.retirement_type        retirement_type
      json.contact_seller         contact_seller
      json.contact_phone          contact_phone
      json.accept_terms           accept_terms
      json.cart_id                cart.id
      json.branch_id              branch.id
      json.retirement_branch      retirement_branch
      json.branch_installation    branch_installation
      json.delivery_installation  delivery_installation
      json.street_address         street_address
      json.number_address         number_address
      json.region                 comune.region.name if comune
      json.comune                 comune.desc_comuna if comune
    end
  end
end