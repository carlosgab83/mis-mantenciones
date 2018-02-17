module PaymentSerializer
  def to_event_tracker_builder
    Jbuilder.new do |json|
      json.item0_id         order.buyable_items_array[0].try(:[], :id)
      json.item0_name       order.buyable_items_array[0].try(:[], :name)
      json.item0_quantity   order.buyable_items_array[0].try(:[], :quantity)
      json.item0_unit_price order.buyable_items_array[0].try(:[], :unit_price)
      json.total_price      order.cart.price
    end
  end
end