class ShopInscriptionCreatedMailer < ApplicationMailer

  def notify_admin(shop_inscription)
    template_name = 'mismantenciones-com-shop-inscription'
    template_content = []
    message = {
      from_name: default_from_name,
      from_email: default_from_email,
      to: [{email: 'contacto@mismantenciones.com'}],
      subject: 'Solicitud de inscripción de Shop',
      merge_vars: [
        {
          rcpt: 'contacto@mismantenciones.com',
          vars: [
            {name: 'CLIENT_NAME', content: shop_inscription.full_name},
            {name: 'CLIENT_EMAIL', content: shop_inscription.email},
            {name: 'CLIENT_PHONE', content: shop_inscription.phone},
            {name: 'COMPANY_NAME', content: shop_inscription.company_name},
            {name: 'COMPANY_RUT', content: shop_inscription.company_rut},
            {name: 'COPY_RIGHT_YEAR', content: Date.today.year},
            {name: 'COMPANY_CATEGORY', content: shop_inscription.branch_types},
            {name: 'COMPANY_COMUNE', content: shop_inscription.comune.desc_comuna},
            {name: 'COMPANY_ADDRESS', content: shop_inscription.address},
          ]
        }
      ]
    }
    mandrill_client.messages.send_template template_name, template_content, message
  end
end
