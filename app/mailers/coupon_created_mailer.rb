class CouponCreatedMailer < ApplicationMailer

  def notify_client(coupon)
    @coupon = coupon
    mail  to: @coupon.client.email,
          subject: "Has adquirido una #{@coupon.promotion.name} para el #{@coupon.date}."
  end

  def notify_shop(coupon)
    @coupon = coupon
    mail  to: @coupon.promotion.branches.first.shop.email,
          subject: "#{@coupon.client.email} Ha adquirido una #{@coupon.promotion.name} para el #{@coupon.date}."
  end
end
