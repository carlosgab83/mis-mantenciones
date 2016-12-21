module CategorySerializer
  def to_event_tracker_builder
    Jbuilder.new do |json|
      json.category_id   id
      json.category_name name
    end
  end
end
