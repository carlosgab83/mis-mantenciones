module BrandSerializer
  def to_event_tracker_builder
    Jbuilder.new do |json|
      json.brand_id   id_marca
      json.brand_name descripcion
    end
  end
end
