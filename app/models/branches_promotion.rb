class BranchesPromotion < ApplicationRecord
  belongs_to :branch
  belongs_to :promotion

  FOLLOW_PROMOTION_URL = 0
  MISMANTENCIONES_CHECKOUT = 1

  def price
    promotion.try(:promo_price)
  end

  def buyable_item
    promotion
  end

  # Decide checkout method

  def mismantenciones_checkout?
    checkout_method == MISMANTENCIONES_CHECKOUT
  end
end
