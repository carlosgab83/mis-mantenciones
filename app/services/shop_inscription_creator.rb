class ShopInscriptionCreator < BaseService

  def call
    shop_inscription = ShopInscription.find_or_create_by(email:params[:email])
    shop_inscription.update_attributes(params)
    shop_inscription
  end
end
