module PaymentsGateway
  module Webpay
    module Normal
      class Transaction < PaymentsGateway::Webpay::TransactionBase

        include PaymentsGateway::Webpay::Lib::TransportLayer
        include PaymentsGateway::Webpay::Normal::Lib::TransactionInitiator
        # include PaymentsGateway::Webpay::Lib::TransactionConfirmator
        # include PaymentsGateway::Webpay::Lib::TransactionAcknowledger

        def initialize
          super
        end

        private

        attr_accessor :amount, :session_id, :buy_order, :extra_args

      end
    end
  end
end
