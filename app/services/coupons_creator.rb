class CouponsCreator < BaseService

  def call
    promotion = Promotion.availables.actives.with_stock.not_deleted.where(id: params[:promotion_id]).first
    coupon = nil
    Promotion.transaction do
      coupon = Coupon.create(
        promotion_id: params[:promotion_id],
        client_id: params[:client_id],
        date: Date.today,
        price: promotion.promo_price
      )
      if promotion.max_coupons.present?
        promotion.max_coupons-= 1
        promotion.save
      end
    end

    send_confirmation_emails
    coupon

  rescue Exception => e
    puts e.message
    puts e.backtrace
    return nil
  end

  def send_confirmation_emails
    # To DO
  end
end
