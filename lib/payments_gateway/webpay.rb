require 'payments_gateway/webpay/configuration'

module PaymentsGateway
  module Webpay

    def self.configuration
      @@configuration ||= Configuration.new
    end

    def self.reset
      @@configuration = Configuration.new
    end

    def self.configure
      yield(configuration)
    end
  end
end
