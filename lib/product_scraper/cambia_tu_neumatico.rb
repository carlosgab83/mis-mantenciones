module ProductScraper
  class CambiaTuNeumatico < Base

    def price
      numerize_price page.at('.prod-precio .red').try(:text).try(:strip)
    end
  end
end