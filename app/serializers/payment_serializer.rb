module PaymentSerializer
  def to_event_tracker_builder
    Jbuilder.new do |json|
      json.amount amount
      json.status status
      json.order_number order.try(:order_number)
    end
  end
end