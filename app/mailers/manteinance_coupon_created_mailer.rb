class ManteinanceCouponCreatedMailer < ApplicationMailer

  def notify_client(manteinance_coupon, vehicle_brand, vehicle_model)
    @manteinance_coupon = manteinance_coupon
    @vehicle_brand = vehicle_brand
    @vehicle_model = vehicle_model
    mail  to: @manteinance_coupon.client.email,
          subject: "Has adquirido una #{@manteinance_coupon.pauta.name} para el #{@manteinance_coupon.date} en #{@manteinance_coupon.branch.shop.name}."
  end

  def notify_branch(manteinance_coupon, vehicle_brand, vehicle_model)
    @manteinance_coupon = manteinance_coupon
    @vehicle_brand = vehicle_brand
    @vehicle_model = vehicle_model
    mail  to: @manteinance_coupon.branch.email,
          subject: "#{@manteinance_coupon.client.email} Ha adquirido una #{@manteinance_coupon.pauta.name} para el #{@manteinance_coupon.date}."
  end
end
