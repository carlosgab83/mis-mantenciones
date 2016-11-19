module BranchPautaSerializer
  def to_builder
    Jbuilder.new do |json|
      json.id                       pauta.id_pauta
      json.name                     pauta.name
      json.kms                      pauta.kilometraje
      json.promo_price              promo_price
      json.full_price               full_price
      json.discount_percentage      discount_percentage
      json.branch_manteinance_items branches_manteinance_items.map{|bmi| bmi.to_builder.attributes!}
    end
  end
end
