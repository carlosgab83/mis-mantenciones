class CouponsNotifier < BaseService

  def call
    CouponCreatedMailer.notify_client(params[:coupon]).deliver_later
    CouponCreatedMailer.notify_shop(params[:coupon]).deliver_later
  end
end
