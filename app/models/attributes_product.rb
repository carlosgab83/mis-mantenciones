class AttributesProduct < ApplicationRecord
  belongs_to :product_attribute, class_name: Attribute, foreign_key: :attribute_id
  belongs_to :product, touch: true

  default_scope {order(:id)}
end
