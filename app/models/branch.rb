class Branch < ApplicationRecord
  belongs_to :shop
  belongs_to :comune, foreign_key: :commune_id
  belongs_to :branch_type
  belongs_to :plan
  has_many :branches_products
  has_many :branches_promotions
  has_many :products, through: :branches_products
  has_many :promotions, through: :branches_promotions
  has_many :branches_manteinance_items

  HIDE_BRANCH_PRICE_VALUE = -999

  include BranchSerializer
  extend BranchesSerializer
  extend FriendlyId

  # Use friendly id based on name
  friendly_id :name, use: :slugged

  scope :for_pauta, -> (pauta) do
    actives.includes(:shop).where(id: ids_for_pauta(pauta))
  end

  scope :ids_for_pauta, -> (pauta) do
    BranchesManteinanceItem.where(pauta: pauta).pluck(:branch_id).uniq &
    Branch.actives.pluck(:id)
  end

  scope :actives, -> do
    joins(:shop).where("shops.status is true")
  end

  scope :with_plan, -> do
    where.not(plan_id: nil)
  end

  def branches_manteinance_items_by_pauta(pauta)
    branches_manteinance_items.includes(manteinance_item: :section_type).where(pauta: pauta)
  end

  def branches_manteinance_items_count_by_pauta(pauta)
    branches_manteinance_items.select("count(branches_manteinance_items.id) as count_manteinance_items")
    .where(pauta: pauta)
    .order('')
    .first['count_manteinance_items']
  end

  # Loads an obj that stores all manteinance_items offered by this branch for this pauta
  def branch_pauta(pauta)
    BranchPauta.new(branch: self, pauta: pauta).load
  end

  def promo_price(pauta)
    branch_pauta(pauta).promo_price
  end

  def full_price(pauta)
    branch_pauta(pauta).full_price
  end
end
