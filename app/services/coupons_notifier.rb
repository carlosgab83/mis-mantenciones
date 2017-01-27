class CouponsNotifier < BaseService

  PROMOTIONS_TO_SHOW_IN_EMAIL = 3

  def call
    promotions_ids = CarouselPromotionsFinder.new(vehicle: params[:vehicle]).call[0..(PROMOTIONS_TO_SHOW_IN_EMAIL-1)].map &:id
    CouponCreatedMailer.notify_client(params[:coupon], promotions_ids, params[:vehicle].patent, params[:vehicle].kms).deliver_later
    CouponCreatedMailer.notify_shop(params[:coupon], params[:vehicle].patent, params[:vehicle].kms).deliver_later
  end
end
