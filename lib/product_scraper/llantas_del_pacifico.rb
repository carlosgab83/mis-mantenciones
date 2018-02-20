module ProductScraper
  class LlantasDelPacifico < Base

    def price
      numerize_price page.at('#productosdetalle .valor').try(:text).try(:strip)
    end

    private

    def after_instance_hook
      return true if Rails.env.development?
      mechanize.set_proxy(ENV['PROXY_IP'], ENV['PROXY_PORT'])
    end
  end
end