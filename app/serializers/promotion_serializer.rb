module PromotionSerializer
  def to_event_tracker_builder
    Jbuilder.new do |json|
      json.promotion_id   id
      json.promotion_name name
    end
  end
end