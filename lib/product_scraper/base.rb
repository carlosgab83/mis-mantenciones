require 'mechanize'

module ProductScraper
  class Base
    attr_accessor :page, :mechanize

    def initialize(url = nil)
      return self unless url
      self.mechanize = Mechanize.new
      after_instance_hook
      self.page = mechanize.get(url)
    end

    def scraper_instance(url)
      return nil if url.nil?

      case URI.parse(url).host
      when 'www.fullneumaticos.cl'
        return FullNeumaticos.new(url)
      when 'www.cambiatuneumatico.com'
        return CambiaTuNeumatico.new(url)
      when 'llantasdelpacifico-px.rtrk.cl', 'www.llantasdelpacifico.cl', 'llantasdelpacifico.cl'
        return LlantasDelPacifico.new(url)
      else
        return nil
      end
    end

    private

    def numerize_price(price_str)
      return nil unless price_str
      price_str.delete!('.')
      price_str.delete!('$')
      price_str.to_f
    end

    protected

    def after_instance_hook
      # rewrite by each instance
    end
  end
end