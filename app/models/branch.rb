class Branch < ApplicationRecord
  belongs_to :shop
  has_many :branches_products
  has_many :products, through: :branches_products
end
