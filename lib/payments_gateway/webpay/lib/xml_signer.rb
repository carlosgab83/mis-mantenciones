module PaymentsGateway
  module Webpay
    module Lib

      class XmlSigner

        def initialize(certificate_path, private_key)
          self.certificate_path = certificate_path
          self.private_key = private_key
        end

        def sign(xml_to_sign)
          document = Nokogiri::XML(xml_to_sign)
          envelope = document.at_xpath("//env:Envelope")
          envelope.prepend_child("<env:Header><wsse:Security xmlns:wsse='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd' wsse:mustUnderstand='1'/></env:Header>")
          signer = get_signer(document)

          signer.document.xpath("//soapenv:Body", { "soapenv" => "http://schemas.xmlsoap.org/soap/envelope/" }).each do |node|
            signer.digest!(node)
          end

          signer.sign!(issuer_serial: true)
          add_x509_data(signer.to_xml)
        end

        private

        attr_accessor :certificate_path, :private_key

        def get_signer(document)
          signer = Signer.new(document.to_s)
          signer.cert = OpenSSL::X509::Certificate.new(File.read certificate_path)
          signer.private_key = OpenSSL::PKey::RSA.new(private_key)
          signer
        end

        def add_x509_data(signed_xml)
          signed_document = Nokogiri::XML(signed_xml)
          x509data = signed_document.at_xpath("//*[local-name()='X509Data']")
          new_data = x509data.clone()
          new_data.set_attribute("xmlns:ds", "http://www.w3.org/2000/09/xmldsig#")
          x509data = signed_document.at_xpath("//*[local-name()='X509Data']")
          new_data = x509data.clone()
          new_data.set_attribute("xmlns:ds", "http://www.w3.org/2000/09/xmldsig#")
          n = Nokogiri::XML::Node.new('wsse:SecurityTokenReference', signed_document)
          n.add_child(new_data)
          x509data.add_next_sibling(n)
          return signed_document
        end
      end
    end
  end
end