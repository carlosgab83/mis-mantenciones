module PromotionsSerializer
  def to_promotions_carousel_event_tracker_builder(promotions)
    Jbuilder.new do |json|
      json.promotion1_id    promotions[0].try(:id)
      json.promotion1_name  promotions[0].try(:name)
      json.promotion2_id    promotions[1].try(:id)
      json.promotion2_name  promotions[1].try(:name)
      json.promotion3_id    promotions[2].try(:id)
      json.promotion3_name  promotions[2].try(:name)
      json.promotion4_id    promotions[3].try(:id)
      json.promotion4_name  promotions[3].try(:name)
      json.promotion5_id    promotions[4].try(:id)
      json.promotion5_name  promotions[4].try(:name)
      json.promotion6_id    promotions[5].try(:id)
      json.promotion6_name  promotions[5].try(:name)
    end
  end
end