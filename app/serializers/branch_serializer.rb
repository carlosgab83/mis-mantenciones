module BranchSerializer
  def to_manteinance_alternatives_builder(pauta)
    Jbuilder.new do |json|
      json.id           id
      json.name         name
      json.shop_id      shop_id
      json.shop_name    shop.name
      json.will_contact will_contact
      json.booking_url  booking_url
      json.branch_pauta branch_pauta(pauta).to_builder
    end
  end

  def to_event_tracker_builder
    Jbuilder.new do |json|
      json.branch_id           id
      json.branch_name         name
    end
  end
end
