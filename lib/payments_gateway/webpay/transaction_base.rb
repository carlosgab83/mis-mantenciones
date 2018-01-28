module PaymentsGateway
  module Webpay

    class TransactionBase
      attr_reader :wsdl_path

      def initialize
        self.wsdl_path = PaymentsGateway::Webpay.configuration.integration_endpoint
      end

      protected

      attr_accessor :wsdl_path

      def confirmation_url
        extra_args[:confirmation_url] || PaymentsGateway::Webpay.configuration.confirmation_url
      end

      def final_url
        extra_args[:final_url] || PaymentsGateway::Webpay.configuration.final_url
      end

      def commerce_code
        extra_args[:commerce_code] || PaymentsGateway::Webpay.configuration.commerce_code
      end
    end
  end
end