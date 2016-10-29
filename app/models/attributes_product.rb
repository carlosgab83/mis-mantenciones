class AttributesProduct < ApplicationRecord
  belongs_to :attribute
  belongs_to :product
end
