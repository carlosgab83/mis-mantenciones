class CouponCreatedMailer < ApplicationMailer

  def notify_client(coupon, promotions_ids, patent, kms)
    template_name = (coupon.promotion.info_modal? or coupon.promotion.is_a?(BranchInformation)) ? 'mismantenciones-com-cupon-information' : 'mismantenciones-com-cupon-derco'
    subject = (coupon.promotion.info_modal?  or coupon.promotion.is_a?(BranchInformation)) ? "Has solicitado más información en #{coupon.promotion.branches.first.try(:shop).try(:name)}." : "Has adquirido un cupón de servicio en #{coupon.promotion.branches.first.try(:shop).try(:name)}."
    template_content = []
    message = {
      from_name: default_from_name,
      from_email: default_from_email,
      to: [{email: coupon.client.email}],
      subject: subject,
      merge_vars: [
        {
          rcpt: coupon.client.email,
          vars: [
            {name: 'CLIENT_NAME', content: coupon.client.name},
            {name: 'SHOP_NAME', content: coupon.promotion.branches.first.try(:shop).try(:name)},
            {name: 'PROMO_NAME', content: coupon.promotion.name},
            {name: 'PROMO_TO_DATE', content: coupon.promotion.to_date},
            {name: 'TICKET_NUMBER', content: coupon.id},
            {name: 'PROMOS_SECTION', content: CarouselPromotionsCreatorForMailer.new(promotions_ids: promotions_ids, patent: patent, kms: kms).call},
            {name: 'PROMO_DESCRIPTION', content: coupon.promotion.description},
            {name: 'PROMO_IMAGE_URL', content: coupon.promotion.image_url},
            {name: 'PROMO_URL', content: PromotionUrlGenerator.new(promotion: coupon.promotion, patent: patent, kms: kms).call},
            {name: 'COPY_RIGHT_YEAR', content: Date.today.year},
            {name: 'BRAND_NAME', content: coupon.client.brand},
            {name: 'MANTEINANCE_TYPE', content: coupon.client.manteinance_type},
            {name: 'COMUNE_NAME', content: coupon.client.comune.desc_comuna}
          ]
        }
      ]
    }
    mandrill_client.messages.send_template template_name, template_content, message

  end

  def notify_shop(coupon, patent, kms)
    template_name = (coupon.promotion.info_modal? or coupon.promotion.is_a?(BranchInformation)) ? 'mismantenciones-com-cupon-branch-information' : 'mismantenciones-com-cupon-branch-derco'
    subject = (coupon.promotion.info_modal? or coupon.promotion.is_a?(BranchInformation)) ? "Cliente: #{coupon.client.full_name} ha solicitado más información en #{coupon.promotion.branches.first.try(:shop).try(:name)}." : "#{coupon.client.name} ha adquirido un cupón de servicio en #{coupon.promotion.branches.first.try(:shop).try(:name)}."
    template_content = []
    splitted_emails = coupon.promotion.branches.first.try(:shop).try(:email).try(:split, ',')
    message = {}
    splitted_emails.each do |email|
      message = {
        from_name: default_from_name,
        from_email: default_from_email,
        to: [{email: email}],
        subject: subject,
        merge_vars: [
          {
            rcpt: email,
            vars: [
              {name: 'CLIENT_NAME', content: coupon.client.name},
              {name: 'SHOP_NAME', content: coupon.promotion.branches.first.try(:shop).try(:name)},
              {name: 'PROMO_NAME', content: coupon.promotion.name},
              {name: 'TICKET_NUMBER', content: coupon.id},
              {name: 'PROMO_DESCRIPTION', content: coupon.promotion.description},
              {name: 'PROMO_IMAGE_URL', content: coupon.promotion.image_url},
              {name: 'PROMO_URL', content: PromotionUrlGenerator.new(promotion: coupon.promotion, patent: patent, kms: kms).call},
              {name: 'COPY_RIGHT_YEAR', content: Date.today.year},
              {name: 'CLIENT_EMAIL', content: coupon.client.email},
              {name: 'CLIENT_PHONE', content: coupon.client.phone},
              {name: 'BRAND_NAME', content: coupon.client.brand},
              {name: 'MANTEINANCE_TYPE', content: coupon.client.manteinance_type},
              {name: 'COMUNE_NAME', content: coupon.client.comune.desc_comuna},
              {name: 'CLIENT_MESSAGE', content: coupon.client.message}
            ]
          }
        ]
      }
      mandrill_client.messages.send_template template_name, template_content, message
    end
    message[:merge_vars][0][:rcpt] = 'contacto@mismantenciones.com'
    message[:to] = [{email: 'contacto@mismantenciones.com'}]
    mandrill_client.messages.send_template template_name, template_content, message
  end
end
