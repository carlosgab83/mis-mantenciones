module ProductSerializer
  def to_event_tracker_builder
    Jbuilder.new do |json|
      json.product_id   id
      json.product_name name
    end
  end
end