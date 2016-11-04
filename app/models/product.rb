class Product < ApplicationRecord
  self.table_name="products"
  belongs_to :product_type
  belongs_to :category
  belongs_to :product_brand
  has_many :attributes_products
  has_many :product_attributes, through: :attributes_products
end
