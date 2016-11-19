class CreateManteinanceCouponsItem < ApplicationRecord
  belongs_to :manteinance_coupon
  belongs_to :manteinance_item

   validates :manteinance_coupon_id, :manteinance_item_id, :price, presence: true
end
