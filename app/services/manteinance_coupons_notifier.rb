class ManteinanceCouponsNotifier < BaseService

  PROMOTIONS_TO_SHOW_IN_EMAIL = 3

  def call
    promotions_ids = CarouselPromotionsFinder.new(vehicle: params[:vehicle]).call[0..(PROMOTIONS_TO_SHOW_IN_EMAIL-1)].map &:id
    ManteinanceCouponCreatedMailer.notify_client(
      params[:manteinance_coupon],
      params[:vehicle].rvm_brand,
      params[:vehicle].rvm_model,
      promotions_ids,
      params[:vehicle].patent,
      params[:vehicle].kms
    ).deliver_later

    ManteinanceCouponCreatedMailer.notify_branch(
      params[:manteinance_coupon],
      params[:vehicle].patent,
      params[:vehicle].rvm_brand,
      params[:vehicle].rvm_model,
      params[:vehicle].manufacturing_year,
      params[:vehicle].engine_serial,
      params[:vehicle].chassis_serial
    ).deliver_later
  end
end
