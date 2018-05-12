class Attribute < ApplicationRecord

  has_many :attributes_products
  has_many :products, through: :attributes_products

  after_save :update_products

  scope :attributes_products_for_attributes_ids_and_category, -> (attributes_ids, category) do
    return [] if attributes_ids.empty?
    AttributesProduct.includes(:product_attribute)
      .joins(:product)
      .joins(:product_attribute)
      .where("products.category_id = ?", category.id)
      .where("attributes_products.attribute_id in (#{attributes_ids.join(',')})")
      .order("attributes_products.attribute_id")
  end

  private

  def update_products
    products.update_all(updated_at: Time.now)
  end
end
