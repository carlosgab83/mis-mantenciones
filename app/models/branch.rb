class Branch < ApplicationRecord
  belongs_to :shop
  belongs_to :comune
  belongs_to :branch_type
  belongs_to :plan
  has_many :branches_products
  has_many :branches_promotions
  has_many :products, through: :branches_products
  has_many :promotions, through: :branches_promotions

  HIDE_BRANCH_PRICE_VALUE = -999

  include BranchSerializer
  extend BranchesSerializer

  scope :for_pauta, -> (pauta) do
    actives.includes(:shop).where(id: ids_for_pauta(pauta))
  end

  scope :actives, -> do
    joins(:shop).where("shops.status is true")
  end

  scope :with_plan, -> do
    where.not(plan_id: nil)
  end

end
