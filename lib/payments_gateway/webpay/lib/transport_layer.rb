module PaymentsGateway
  module Webpay
    module Lib
      module TransportLayer

        def request(action, data)
          Rails.logger.info "Initiating Webpay transaction: #{action}, data: #{data}"
          xml_data = client.build_request(action, message: data)
          signed_document = sign(xml_data.body)
          webpay_response = send_request(action, signed_document)
          verify!(webpay_response)
          Rails.logger.info "Webpay transaction response: #{action}, response: #{webpay_response.try(:body)}"
          webpay_response
        end

        private

        attr_writer :private_key, :public_certificate, :webpay_public_certificate, :client

        def client
          @client ||= Savon.client(wsdl: wsdl_path)
        end

        def sign(xml_data)
          PaymentsGateway::Webpay::Lib::XmlSigner.new(
            PaymentsGateway::Webpay.configuration.public_certificate_path,
            PaymentsGateway::Webpay.configuration.private_key
          ).sign(xml_data)
        end

        def send_request(action, document)
          response = client.call(action) do
            xml document.to_xml(save_with: 0)
          end
        end

        def verify!(response)
          raise 'Invalid Tbk certificate' unless PaymentsGateway::Webpay::Lib::Verifier.new.verify(response)
        end
      end
    end
  end
end