module PaymentsGateway
  module Webpay
    module Normal
      module Lib
        module TransactionInitiator

          attr_accessor :extra_args

          def initiate(amount, session_id, buy_order, extra_args = {})
            self.extra_args = extra_args

            data ={
              "wsInitTransactionInput" => {
                "wSTransactionType" => "TR_NORMAL_WS",
                "buyOrder" => buy_order,
                "sessionId" => session_id,
                "returnURL" => confirmation_url,
                "finalURL" => final_url,
                "transactionDetails" => {
                  "amount" => amount,
                  "commerceCode" => commerce_code,
                  "buyOrder" => buy_order
                }
              }
            }

            response = request(:init_transaction, data)

            token = ''
            url = ''
            response_document = Nokogiri::HTML(response.to_s)

            response_document.xpath("//token").each do |token_value|
              token = token_value.text
            end

            response_document.xpath("//url").each do |url_value|
              url = url_value.text
            end

            {token: token, url: url}
          end
        end
      end
    end
  end
end