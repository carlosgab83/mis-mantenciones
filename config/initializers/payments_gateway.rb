PaymentsGateway::Webpay.configure do |config|

  # Can be overwritten
  config.confirmation_url = 'https://mismantenciones.herokuapp.com/webpay/confirmation'

  config.final_url = 'https://mismantenciones.herokuapp.com/webpay/final'

  if Rails.env.development?
    config.private_key = File.read('lib/payments_gateway/webpay/data/597020000541.key')
    config.public_certificate_path = 'lib/payments_gateway/webpay/data/597020000541.crt'
    config.public_webpay_certificate_path = 'lib/payments_gateway/webpay/data/tbk.pem'
    config.commerce_code = '597020000541'
    config.integration_endpoint = 'https://webpay3gint.transbank.cl/WSWebpayTransaction/cxf/WSWebpayService?wsdl'
    config.confirmation_url = 'http://190.46.97.234:3000/webpay/confirmation'
    config.final_url = 'http://190.46.97.234:3000/checkout/payment_results'
  end

  if Rails.env.staging?
    config.private_key = ENV['TBK_WEBPAY_PRIVATE_KEY']
    config.public_certificate_path = ENV['TBK_WEBPAY_PUBLIC_CERTIFICATE_PATH']
    config.public_webpay_certificate_path = ENV['TBK_WEBPAY_PUBLIC_WEBPAY_CERTIFICATE_PATH']
    config.commerce_code = '597020000541'
    config.integration_endpoint = 'https://webpay3gint.transbank.cl/WSWebpayTransaction/cxf/WSWebpayService?wsdl'
    config.confirmation_url = 'https://mismantenciones.herokuapp.com/webpay/confirmation'
    config.final_url = 'https://mismantenciones.herokuapp.com/payment_results'
  end

  if Rails.env.production?
    config.private_key = ENV['TBK_WEBPAY_PRIVATE_KEY']
    config.public_certificate_path = ENV['TBK_WEBPAY_PUBLIC_CERTIFICATE_PATH']
    config.public_webpay_certificate_path = ENV['TBK_WEBPAY_PUBLIC_WEBPAY_CERTIFICATE_PATH']
    config.commerce_code = ENV['TBK_WEBPAY_COMMERCE_CODE']
    config.integration_endpoint = ''
    config.confirmation_url = ''
    config.final_url = ''
  end
end