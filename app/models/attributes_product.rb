class AttributesProduct < ApplicationRecord
  belongs_to :product_attribute, class_name: :attribute
  belongs_to :product
end
