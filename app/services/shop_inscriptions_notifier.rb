class ShopInscriptionsNotifier < BaseService

  def call
    ShopInscriptionCreatedMailer.notify_admin(params[:shop_inscription]).deliver_later
  end
end
