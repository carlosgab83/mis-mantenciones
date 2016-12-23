module ProductScraper
  class LlantasDelPacifico < Base

    def price
      numerize_price page.at('#productosdetalle .valor').try(:text).try(:strip)
    end
  end
end