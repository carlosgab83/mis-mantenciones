class ManteinanceCouponCreatedMailer < ApplicationMailer

  def notify_client(manteinance_coupon, vehicle_brand, vehicle_model, promotions_ids, patent, kms)
    template_name = 'mismantenciones-com-ticket-mantenci-n'
    template_content = []
    message = {
      from_name: default_from_name,
      from_email: default_from_email,
      to: [{email: manteinance_coupon.client.email}],
      subject: "Has adquirido una #{manteinance_coupon.pauta.name} en #{manteinance_coupon.branch.shop.name}.",
      merge_vars: [
        {
          rcpt: manteinance_coupon.client.email,
          vars: [
            {name: 'CLIENT_NAME', content: manteinance_coupon.client.name},
            {name: 'VEHICLE_NAME', content: "#{vehicle_brand} #{vehicle_model}"},
            {name: 'SHOP_NAME', content: manteinance_coupon.branch.shop.name},
            {name: 'BRANCH_NAME', content: manteinance_coupon.branch.name},
            {name: 'TICKET_NUMBER', content: manteinance_coupon.id},
            {name: 'PROMOS_SECTION', content: CarouselPromotionsCreatorForMailer.new(promotions_ids: promotions_ids, patent: patent, kms: kms).call},
            {name: 'COPY_RIGHT_YEAR', content: Date.today.year},
          ]
        }
      ]
    }
    mandrill_client.messages.send_template template_name, template_content, message
  end

  def notify_branch(manteinance_coupon, patent, vehicle_brand, vehicle_model, manufacturing_year, engine_serial, chassis_serial)
    template_name = 'mismantenciones-com-ticket-branch'
    template_content = []
    message = {
      from_name: default_from_name,
      from_email: default_from_email,
      to: [{email: manteinance_coupon.branch.email}, {email: manteinance_coupon.branch.shop.email}],
      subject: "Cliente: #{manteinance_coupon.client.full_name} a adquirido una #{manteinance_coupon.pauta.name} en #{manteinance_coupon.branch.name}.",
      merge_vars: [
        {
          rcpt: manteinance_coupon.client.email,
          vars: [
            {name: 'CLIENT_NAME', content: manteinance_coupon.client.full_name},
            {name: 'CLIENT_EMAIL', content: manteinance_coupon.client.email},
            {name: 'CLIENT_PHONE', content: manteinance_coupon.client.phone},
            {name: 'PAUTA_NAME', content: manteinance_coupon.pauta.name},
            {name: 'SHOP_NAME', content: manteinance_coupon.branch.shop.name},
            {name: 'BRANCH_NAME', content: manteinance_coupon.branch.name},
            {name: 'VEHICLE_NAME', content: "#{vehicle_brand} #{vehicle_model}"},
            {name: 'RVM', content: patent},
            {name: 'RVM_BRAND', content: vehicle_brand},
            {name: 'RVM_MODEL', content: vehicle_model},
            {name: 'RVM_YEAR', content: manufacturing_year},
            {name: 'RVM_CHASSIS', content: chassis_serial},
            {name: 'RVM_MOTOR', content: engine_serial},
            {name: 'TICKET_NUMBER', content: manteinance_coupon.id},
            {name: 'COPY_RIGHT_YEAR', content: Date.today.year},
          ]
        }
      ]
    }
    mandrill_client.messages.send_template template_name, template_content, message
  end
end
