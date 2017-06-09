module ProductsSerializer
  def to_products_carousel_event_tracker_builder(products)
    Jbuilder.new do |json|
      json.product1_id    products[0].try(:id)
      json.product1_name  products[0].try(:name)
      json.product2_id    products[1].try(:id)
      json.product2_name  products[1].try(:name)
      json.product3_id    products[2].try(:id)
      json.product3_name  products[2].try(:name)
      json.product4_id    products[3].try(:id)
      json.product4_name  products[3].try(:name)
      json.product5_id    products[4].try(:id)
      json.product5_name  products[4].try(:name)
      json.product6_id    products[5].try(:id)
      json.product6_name  products[5].try(:name)
    end
  end
end