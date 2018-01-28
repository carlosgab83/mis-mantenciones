require 'payments_gateway/webpay/configuration'

module PaymentsGateway
  module Webpay
    class << self
      attr_accessor :configuration

      def configuration
        @configuration ||= PaymentsGateway::Webpay::Configuration.new
      end

      def reset
        @configuration = PaymentsGateway::Webpay::Configuration.new
      end

      def configure
        yield(configuration)
      end
    end
  end
end
