module ProductScraper
  class CambiaTuNeumatico < Base

    def price
      numerize_price(page.at('.prod-precio .red').try(:text).try(:strip)) ||
      numerize_price(page.at('.precio-final-ficha').try(:text).try(:strip)) ||
      numerize_price(page.at('.precio-normal-ficha').try(:text).try(:strip))
    end
  end
end