class BranchesManteinanceItem < ApplicationRecord
  belongs_to :pauta
  belongs_to :manteinance_item
  belongs_to :branch
end
