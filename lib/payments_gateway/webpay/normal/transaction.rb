module PaymentsGateway
  module Webpay
    module Normal
      class Transaction < PaymentsGateway::Webpay::TransactionBase

        include PaymentsGateway::Webpay::Lib::TransportLayer
        include PaymentsGateway::Webpay::Normal::Lib::TransactionInitiator
        include PaymentsGateway::Webpay::Normal::Lib::TransactionConfirmator
        include PaymentsGateway::Webpay::Normal::Lib::TransactionAcknowledger

        def initialize
          super
        end
      end
    end
  end
end
