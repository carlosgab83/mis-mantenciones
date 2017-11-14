PaymentsGateway::Webpay.configure do |config|

  config.private_key = File.read('lib/payments_gateway/webpay/data/597020000541.key')

  config.public_certificate_path = 'lib/payments_gateway/webpay/data/597020000541.crt'

  config.public_webpay_certificate_path = 'lib/payments_gateway/webpay/data/tbk.pem'

  if Rails.env.development?
    config.commerce_code = '597020000541'
    config.integration_endpoint = 'https://webpay3gint.transbank.cl/WSWebpayTransaction/cxf/WSWebpayService?wsdl'
    config.confirmation_url = 'https://mismantenciones.herokuapp.com/webpay/confirmation'
    config.final_url = 'https://mismantenciones.herokuapp.com/webpay/final'
  end

  if Rails.env.staging?
    config.commerce_code = ''
    config.integration_endpoint = ''
    config.confirmation_url = 'https://mismantenciones.herokuapp.com/webpay/confirmation'
    config.final_url = 'https://mismantenciones.herokuapp.com/webpay/final'
  end

  if Rails.env.production?
    config.commerce_code = ''
    config.integration_endpoint = ''
    config.confirmation_url = ''
    config.final_url = ''
  end

  # Can be overwritten
  config.confirmation_url = 'https://mismantenciones.herokuapp.com/webpay/confirmation'

  config.final_url = 'https://mismantenciones.herokuapp.com/webpay/final'

end