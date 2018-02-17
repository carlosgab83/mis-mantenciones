class SuccessPaymentNotifier < BaseService

  PROMOTIONS_TO_SHOW_IN_EMAIL = 3

  def call
    promotions_ids = CarouselPromotionsFinder.new(vehicle: params[:vehicle]).call[0..(PROMOTIONS_TO_SHOW_IN_EMAIL-1)].map(&:id)
    SuccessPaymentMailer.notify_client(params[:payment], promotions_ids, params[:vehicle].patent, params[:vehicle].kms).deliver_later
  end
end
