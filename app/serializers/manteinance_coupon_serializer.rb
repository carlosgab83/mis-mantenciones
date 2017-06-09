module ManteinanceCouponSerializer
  def to_event_tracker_builder
    Jbuilder.new do |json|
      json.manteinance_coupon_id id
      json.manteinance_coupon_price price
    end
  end
end
