module BranchesManteinanceItemSerializer
  def to_builder
    Jbuilder.new do |json|
      json.id                       manteinance_item.id_item_mantencion
      json.promo_price              promo_price
      json.full_price               full_price
      json.discount_percentage      discount_percentage
    end
  end
end
