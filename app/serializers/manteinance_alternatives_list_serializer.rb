module ManteinanceAlternativesListSerializer
  def to_builder
    Jbuilder.new do |json|
      json.pauta         pauta.to_manteinance_alternatives_builder
      json.similar_pautas similar_pautas.map{|pauta| pauta.to_similar_pauta_manteinance_alternatives_builder.attributes!}
      json.branches      branches.map{|branch| branch.to_manteinance_alternatives_builder(pauta).attributes!}
    end
  end
end