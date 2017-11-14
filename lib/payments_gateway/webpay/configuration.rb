module PaymentsGateway
  module Webpay

    class Configuration
      attr_accessor :private_key, :public_certificate_path, :public_webpay_certificate_path, :commerce_code, :confirmation_url, :final_url, :integration_endpoint

      def initialize
        self.private_key = nil
        self.public_certificate_path = nil
        self.public_webpay_certificate_path = nil
        self.commerce_code = nil
        self.confirmation_url = nil
        self.final_url = nil
        self.integration_endpoint = nil
      end
    end
  end
end