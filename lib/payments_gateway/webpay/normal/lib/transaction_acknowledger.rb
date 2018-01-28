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
            Rails.logger.info "Webpay Acknowledge response code: #{response.http.code}"
            response
          end
        end
      end
    end
  end
end