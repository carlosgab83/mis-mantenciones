class ManteinanceCouponsCreator < BaseService

  def call
    pauta = Pauta.where(id_pauta: params[:pauta_id]).first
    branch_pauta = Branch.where(id: params[:branch_id]).first.branch_pauta(pauta).load

    manteinance_coupon = nil
    ActiveRecord::Base.transaction do
      manteinance_coupon = ManteinanceCoupon.create(
        pauta_id: params[:pauta_id],
        branch_id: params[:branch_id],
        client_id: params[:client_id],
        date: Date.today,
        price: branch_pauta.promo_price
      )

      raise unless manteinance_coupon
      create_manteinance_coupon_items(manteinance_coupon, branch_pauta)
    end
    send_confirmation_emails
    manteinance_coupon

    rescue Exception => e
      puts e.message
      puts e.backtrace
      return nil
  end

  def create_manteinance_coupon_items(manteinance_coupon, branch_pauta)
    manteinance_coupon_items = branch_pauta.enabled_branches_manteinance_items.collect do |bmi|
      ManteinanceCouponsItem.new(
        manteinance_coupon_id: manteinance_coupon.id,
        manteinance_item_id: bmi.manteinance_item_id,
        price: bmi.promo_price
      )
    end
    ManteinanceCouponsItem.import(manteinance_coupon_items)
  end

  def send_confirmation_emails
    # To DO
  end
end
