class AttributesPromotion < ApplicationRecord
  belongs_to :promotion_attribute, class_name: Attribute, foreign_key: :attribute_id
  belongs_to :promotion
end
