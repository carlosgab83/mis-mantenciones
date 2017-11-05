class ShopInscriptionsController < ApplicationController
  protect_from_forgery with: :exception

    def new
      @shop_inscription = ShopInscription.new
      respond_to do |format|
        format.js { render(:new, status: :ok) }
        return
      end
    end

  def create
    if create_shop_inscription_params
      @shop_inscription = ShopInscriptionCreator.new(create_shop_inscription_params).call
      if @shop_inscription.valid?
        ShopInscriptionsNotifier.new(shop_inscription: @shop_inscription).call
        EventTracker::RegisterAsShopInscription.new(controller: self, shop_inscription: @shop_inscription).track
        render :create, status: :ok
      else
        render action: :fail, status: 422
      end
    end
  end

  def update
    create
  end

  private

  def create_shop_inscription_params
    params[:shop_inscription][:branch_types] = params[:shop_inscription][:branch_types].is_a?(Array) ?
                                                params[:shop_inscription][:branch_types].reject!{|x| x.blank? or x.nil? or x.to_s == '-1'}.join(', ') :
                                                params[:shop_inscription][:branch_types]
    params.require(:shop_inscription).permit(
      :name, :primary_last_name, :email,
      :phone, :rut, :comune_id, :company_name, :company_rut, :accept_terms, :address, :branch_types
    )
  end
end
