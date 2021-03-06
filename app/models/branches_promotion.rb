class BranchesPromotion < ApplicationRecord
  belongs_to :branch
  belongs_to :promotion

  def price
    promotion.try(:promo_price)
  end

  def buyable_item
    promotion
  end
end
