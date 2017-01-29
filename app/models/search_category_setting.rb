class SearchCategorySetting < ApplicationRecord

  belongs_to :category
  belongs_to :category_attribute, class_name: Attribute, foreign_key: :attribute_id

  scope :not_deleted, -> {where(deleted: [false, nil])}

  # Filter type filled with HORIZONTAL value must be appear on horizontal filters on view
  HORIZONTAL = 0

  # Recursive scope that look attribuutes for an category, if results is empty, look the same on category's parent
  scope :horizontal_attributes_for_category, -> (category) do
    results = not_deleted.where(category: category, filter_type: HORIZONTAL).order(:position)
    return results if results.any?
    return [] if category.root?
    horizontal_attributes_for_category(category.parent)
  end

  scope :vertical_attributes_for_category, -> (category) do
    results = not_deleted.where(category: category).where.not(filter_type: HORIZONTAL).order(:position)
    return results if results.any?
    return [] if category.root?
    vertical_attributes_for_category(category.parent)
  end
end


