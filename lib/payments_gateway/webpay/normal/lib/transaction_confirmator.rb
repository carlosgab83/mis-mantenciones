module PaymentsGateway
  module Webpay
    module Normal
      module Lib
        module TransactionConfirmator

          def confirm(token)
            data ={
              "tokenInput" => token
            }

            response = request(:get_transaction_result, data)

            response_document = Nokogiri::HTML(response.to_s)

            response_code = response_document.xpath("//responsecode").first.try(:text)

            if response_code == '0' or response_code == '-1'
              PaymentsGateway::Webpay::Normal::Transaction.new.acknowledge(token)
            end

            response_document
          end
        end
      end
    end
  end
end