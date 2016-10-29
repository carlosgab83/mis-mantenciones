class Product < ApplicationRecord
  belongs_to :product_type
  belongs_to :category
  belongs_to :product_brand
  has_many :attributes_products
  has_many :attributes, through: :attributes_products
end
