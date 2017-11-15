module PaymentsGateway
  module Webpay
    module Lib
      class Verifier

        def initialize
          self.certificate = OpenSSL::X509::Certificate.new open(PaymentsGateway::Webpay.configuration.public_webpay_certificate_path){|f| f.read}
        end

        def verify(document)
          self.document = Nokogiri::XML(document.to_s, &:noblanks)
          extract_sign_info

          check_digest and check_signature
        end

        private

        attr_accessor :document, :certificate, :sign_info_node

        def check_digest
          sign_info_node.xpath("//ds:Reference", ds: 'http://www.w3.org/2000/09/xmldsig#').each do |node|
            return false if !process_ref_node(node)
          end
          true
        end

        def check_signature
          signed_info_canon = canonicalize(sign_info_node, ['soap'])
          signature = document.at_xpath(
            '//wsse:Security/ds:Signature/ds:SignatureValue',
            ds: 'http://www.w3.org/2000/09/xmldsig#',
            wsse: "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"
          ).text
          certificate.public_key.verify(OpenSSL::Digest::SHA1.new, Base64.decode64(signature), signed_info_canon)
        end

        def process_ref_node(node)
          uri = node.attr('URI')
          element = document.at_xpath(
            "//*[@wsu:Id='" + uri[1..-1] + "']",
            wsu: "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd"
          )
          target = canonicalize(element, nil)
          my_digest_value = Base64.encode64(digest(target)).strip
          digest_value = node.at_xpath("//ds:DigestValue", ds: 'http://www.w3.org/2000/09/xmldsig#').text
          my_digest_value == digest_value
        end

        def digest(message)
          OpenSSL::Digest::SHA1.new.reset.digest(message)
        end

        def canonicalize(node = document, inclusive_namespaces=nil)
          node.canonicalize(Nokogiri::XML::XML_C14N_EXCLUSIVE_1_0, inclusive_namespaces, nil)
        end

        def extract_sign_info
          self.sign_info_node = document.at_xpath(
            "/soap:Envelope/soap:Header/wsse:Security/ds:Signature/ds:SignedInfo",
            ds: 'http://www.w3.org/2000/09/xmldsig#',
            wsse: "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd",
            soap: "http://schemas.xmlsoap.org/soap/envelope/"
          )
        end
      end
    end
  end
end