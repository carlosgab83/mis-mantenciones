class Branch < ApplicationRecord
  belongs_to :shop
  belongs_to :comune
  belongs_to :branch_type
  belongs_to :plan
  has_many :branches_products
  has_many :products, through: :branches_products

  HIDE_BRANCH_PRICE_VALUE = -999

  include BranchSerializer

  scope :for_pauta, -> (pauta) do
    actives.includes(:shop).where(id: ids_for_pauta(pauta))
  end

  scope :actives, -> do
    joins(:shop).where("shops.status is true")
  end

end
