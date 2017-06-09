module ManteinanceItemSerializer
  def to_builder
    Jbuilder.new do |json|
      json.id                 id_item_mantencion
      json.name               desc_mantencion
      json.section_type_id    section_type.id_tiposeccion
      json.section_type_name  section_type.descripcion
    end
  end
end
