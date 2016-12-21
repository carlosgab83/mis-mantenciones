module CouponSerializer
  def to_event_tracker_builder
    Jbuilder.new do |json|
      json.coupon_id    id
      json.coupon_price price
      json.coupon_promotion_id promotion_id
      json.coupon_promotion_name promotion.name
    end
  end
end
