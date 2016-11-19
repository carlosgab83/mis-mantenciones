module ManteinanceAlternativesListSerializer
  def to_builder
    Jbuilder.new do |json|
      json.pauta     pauta.to_manteinance_alternatives_builder
      json.branches  branches.map{|branch| branch.to_manteinance_alternatives_builder(pauta).attributes!}
    end
  end
end