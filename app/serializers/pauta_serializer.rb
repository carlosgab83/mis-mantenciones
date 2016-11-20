module PautaSerializer
  def to_manteinance_alternatives_builder
    json = basic_builder
    json.manteinance_items manteinance_items.includes(:section_type).map{|mi| mi.to_builder.attributes!}
    json
  end

  def to_similar_pauta_manteinance_alternatives_builder
    basic_builder
  end

  def basic_builder
    Jbuilder.new do |json|
      json.id                       id_pauta
      json.name                     name
      json.kms                      kilometraje
      json.diesel_engine            diesel_engine
      json.double_traction          double_traction
      json.automatic_transmission   automatic_transmission
    end
  end
end