module ModelSerializer
  def to_event_tracker_builder
    Jbuilder.new do |json|
      json.model_id   id_modelo
      json.model_name modelo_descripcion
    end
  end
end
