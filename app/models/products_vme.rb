class ProductsVme < ApplicationRecord

  belongs_to :vme
  belongs_to :product, touch: true
end
