module PaymentsGateway
  module Webpay
    module Normal
      module Lib
        module TransactionAcknowledger

          def acknowledge(token)
            data ={
              "tokenInput" => token
            }

            response = request(:acknowledge_transaction, data)
          end
        end
      end
    end
  end
end