class SuccessPaymentMailer < ApplicationMailer
  include ActionView::Helpers::NumberHelper
  include ApplicationHelper

  def notify_client(payment, promotions_ids, patent, kms)
    template_name = 'mismantenciones-com-client-payment-successful'
    template_content = []
    message = {
      from_name: default_from_name,
      from_email: default_from_email,
      to: [{email: payment.order.client.email}],
      subject: 'Tu compra en mismantenciones.com',
      merge_vars: [
        {
          rcpt: payment.order.client.email,
          vars: [
            {name: 'CLIENT_NAME', content: payment.order.client.full_name},
            {name: 'PRODUCT_NAME', content: payment.order.buyable_items_array.first[:name]},
            {name: 'PRODUCT_QUANTITY', content: payment.order.buyable_items_array.first[:quantity]},
            {name: 'TOTAL_AMOUNT', content: mismantenciones_number_to_currency(payment.order.cart.price)},
            {name: 'SHOP_NAME', content: payment.order.branch.shop.name},
            {name: 'BRANCH_NAME', content: payment.order.branch.name},
            {name: 'ORDER_NUMBER', content: payment.order.order_number},
            {name: 'PROMOS_SECTION', content: CarouselPromotionsCreatorForMailer.new(promotions_ids: promotions_ids, patent: patent, kms: kms).call},
            {name: 'COPY_RIGHT_YEAR', content: Date.today.year}
          ]
        }
      ]
    }
    mandrill_client.messages.send_template template_name, template_content, message
  end

  def notify_branch(payment)
    template_name = 'mismantenciones-com-branch-payment-successful'
    template_content = []
    message = {
      from_name: default_from_name,
      from_email: default_from_email,
      to: [{email: payment.order.branch.email}],
      subject: "Nueva compra en mismantenciones.com - nro Orden #{payment.order.order_number}",
      merge_vars: [
        {
          rcpt: payment.order.branch.email,
          vars: [
            {name: 'CLIENT_NAME', content: payment.order.client.full_name},
            {name: 'CLIENT_EMAIL', content: payment.order.client.email},
            {name: 'CLIENT_PHONE', content: payment.order.client.phone},
            {name: 'CLIENT_RUT', content: payment.order.client.rut},
            {name: 'PRODUCT_NAME', content: payment.order.buyable_items_array.first[:name]},
            {name: 'PRODUCT_QUANTITY', content: payment.order.buyable_items_array.first[:quantity]},
            {name: 'TOTAL_AMOUNT', content: mismantenciones_number_to_currency(payment.order.cart.price)},
            {name: 'SHOP_NAME', content: payment.order.branch.shop.name},
            {name: 'BRANCH_NAME', content: payment.order.branch.name},
            {name: 'ORDER_NUMBER', content: payment.order.order_number},
            {name: 'COPY_RIGHT_YEAR', content: Date.today.year}
          ]
        }
      ]
    }
    mandrill_client.messages.send_template template_name, template_content, message
    message[:merge_vars][0][:rcpt] = 'contacto@mismantenciones.com'
    message[:to] = [{email: 'contacto@mismantenciones.com'}]
    mandrill_client.messages.send_template template_name, template_content, message
  end
end
