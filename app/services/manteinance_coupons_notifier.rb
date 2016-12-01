class ManteinanceCouponsNotifier < BaseService

  def call
    ManteinanceCouponCreatedMailer.notify_client(params[:manteinance_coupon], params[:vehicle].rvm_brand, params[:vehicle].rvm_model).deliver_later
    ManteinanceCouponCreatedMailer.notify_branch(params[:manteinance_coupon], params[:vehicle].rvm_brand, params[:vehicle].rvm_model).deliver_later
  end
end
