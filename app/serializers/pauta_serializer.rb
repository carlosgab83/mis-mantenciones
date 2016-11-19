module PautaSerializer
  def to_manteinance_alternatives_builder
    Jbuilder.new do |json|
      json.id                 id_pauta
      json.name               name
      json.kms                kilometraje
      json.manteinance_items  manteinance_items.includes(:section_type).map{|mi| mi.to_builder.attributes!}
    end
  end
end