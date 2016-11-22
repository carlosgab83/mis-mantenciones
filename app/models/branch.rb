class Branch < ApplicationRecord
  belongs_to :shop
  has_many :branches_products
  has_many :products, through: :branches_products
  has_many :branches_manteinance_items

  include BranchSerializer

  scope :for_pauta, -> (pauta) do
    branches_ids  = BranchesManteinanceItem.where(pauta: pauta).pluck(:branch_id).uniq
    includes(:shop).where(id: branches_ids)
  end

  def branches_manteinance_items_by_pauta(pauta)
    branches_manteinance_items.includes(manteinance_item: :section_type).where(pauta: pauta)
  end

  # Loads an obj that stores all manteinance_items offered by this branch for this pauta
  def branch_pauta(pauta)
    BranchPauta.new(branch: self, pauta: pauta).load
  end
end
