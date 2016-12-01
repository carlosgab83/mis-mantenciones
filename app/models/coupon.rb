class Coupon < ApplicationRecord
  validates :date, :client_id, :promotion_id, presence: true

  belongs_to :promotion
  belongs_to :client
end
