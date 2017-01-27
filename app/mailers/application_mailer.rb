class ApplicationMailer < ActionMailer::Base
  default from: 'MisMantenciones.com <no-reply@mismantenciones.com>'
  layout 'mailer'

  def mandrill_client
    @mandrill_client ||= Mandrill::API.new ENV['MAILER_PASSWORD']
  end

  def default_from_name
    'MisMantenciones.com'
  end

  def default_from_email
    'no-reply@mismantenciones.com'
  end
end
