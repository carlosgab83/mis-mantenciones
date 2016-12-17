class Product < ApplicationRecord
  extend  FriendlyId

  belongs_to :product_type
  belongs_to :category
  belongs_to :product_brand
  has_many :branches_products
  has_many :branches, through: :branches_products
  has_many :attributes_products
  has_many :product_attributes, through: :attributes_products
  has_many :products_vmes
  has_many :vmes, through: :products_vmes

  scope :not_deleted, -> {where(deleted: [false, nil])}

  # Use friendly id based on name
  friendly_id :name, use: :slugged

  def model_attribute_value
    product_model_attribute = Attribute.where(name: 'Modelo').first
    return nil if product_model_attribute.nil?
    attributes_products.where(attribute_id: product_model_attribute.id).first.try(:value)
  end
end


