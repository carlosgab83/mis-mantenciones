class ManteinanceCouponCreatedMailer < ApplicationMailer

  def notify_client(manteinance_coupon, vehicle_brand, vehicle_model)
    template_name = 'mismantenciones-com-ticket'
    template_content = []
    message = {
      from_name: default_from_name,
      from_email: default_from_email,
      to: [{email: manteinance_coupon.client.email}],
      subject: "Has adquirido una #{manteinance_coupon.pauta.name} para el #{manteinance_coupon.date} en #{manteinance_coupon.branch.shop.name}.",
      merge_vars: [
        {
          rcpt: manteinance_coupon.client.email,
          vars: [
            {name: 'CLIENT_NAME', content: manteinance_coupon.client.name},
            {name: 'VEHICLE_NAME', content: "#{vehicle_brand} #{vehicle_model}"},
            {name: 'SHOP_NAME', content: manteinance_coupon.branch.shop.name},
            {name: 'BRANCH_NAME', content: manteinance_coupon.branch.name},
            {name: 'TICKET_NUMBER', content: manteinance_coupon.id}
          ]
        }
      ]
    }
    mandrill_client.messages.send_template template_name, template_content, message
  end

  def notify_branch(manteinance_coupon, vehicle_brand, vehicle_model)
    @manteinance_coupon = manteinance_coupon
    @vehicle_brand = vehicle_brand
    @vehicle_model = vehicle_model
    mail  to: @manteinance_coupon.branch.email,
          subject: "#{@manteinance_coupon.client.email} Ha adquirido una #{@manteinance_coupon.pauta.name} para el #{@manteinance_coupon.date}."
  end
end
