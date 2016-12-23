module ProductScraper
  class FullNeumaticos < Base

    def price
      numerize_price page.at('.precio-detalle.precio').try(:text).try(:strip)
    end
  end
end