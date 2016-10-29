class ManteinanceCoupon < ApplicationRecord
  validates :date, :client_id, :branch_id, :price, :pauta_id, presence: true

  belongs_to :pauta
  belongs_to :client
  belongs_to :branch
end
