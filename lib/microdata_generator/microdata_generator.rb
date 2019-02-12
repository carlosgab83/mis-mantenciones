module MicrodataGenerator

  def jsonld_microdata(request)
    if self.is_a? Promotion
      jsonld_microdata_for_promotion(self, request)
    elsif self.is_a? Product
      jsonld_microdata_for_product(self, request)
    end
  end

  def jsonld_microdata_for_promotion(promotion, request)
    jsonld_microdata_for_offer(
      promotion.category.try(:name),
      promotion.first_branch.try(:comune).try(:desc_comuna),
      "#{promotion.first_branch.try(:street_address)} #{promotion.first_branch.try(:number_address)}",
      promotion.first_branch.try(:shop).try(:name),
      "Service",
      promotion.name,
      promotion.promo_price,
      (promotion.image_url || "promo-image.jpg"),
      request.url,
      promotion.id
    )
  end

  def jsonld_microdata_for_product(product, request)
    json_product = {
      "@context" => "http://schema.org/",
      "@type" => "Product",
      "category" => product.category.try(:name),
      "name" => product.name,
      "description" => product.name,
      "brand" => product.product_brand.try(:name),
      "url" => request.url,
      "image" => product.image_url || "part-image.jpg",
      "offers" => [],
      "id" => id,
      "productID" => id
    }

    product.branches_products_with_prices.each do |bp|
      json_product["offers"] << jsonld_microdata_for_offer(
                              product.category.try(:name),
                              bp.branch.try(:comune).try(:desc_comuna),
                              "#{bp.branch.try(:street_address)} #{bp.branch.try(:number_address)}",
                              bp.branch.try(:shop).try(:name),
                              "Product",
                              product.name,
                              bp.price,
                              (product.image_url || "part-image.jpg"),
                              request.url,
                              id
                            )
    end

    json_product
  end

  def jsonld_microdata_for_offer(category, locality, street_address, place_name, type, description, price, image_url, url, id)
    {
      "@context" => "http://schema.org/",
      "@type" => "Offer",
      "category" => category,
      "areaServed" => jsonld_microdata_for_place(locality, street_address, place_name),
      "ItemOffered" => jsonld_microdata_for_item_offered(type, description),
      "price" => "#{ price.to_i > 0 ? price : "no especificado"}",
      "priceCurrency" => "CLP",
      "url" => url,
      "image": image_url,
      "name": description,
      "itemCondition": "https://schema.org/NewCondition",
      "availability": "https://schema.org/InStock",
      "id": id
    }
  end

  def jsonld_microdata_for_place(locality, street_address, place_name)
    {
      "@type" => "Place",
      "address" => {
        "@type" => "PostalAddress",
        "addressLocality" => locality,
        "streetAddress" => street_address
      },
      "name" => place_name
    }
  end

  def jsonld_microdata_for_item_offered(type, description)
    {
      "@type" => type,
      "description" => description
    }
  end


end