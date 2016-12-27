class Product < ApplicationRecord
  extend FriendlyId
  extend ProductsSerializer
  include ProductSerializer

  belongs_to :product_type
  belongs_to :category
  belongs_to :product_brand
  has_many :branches_products
  has_many :branches, through: :branches_products
  has_many :attributes_products
  has_many :product_attributes, through: :attributes_products
  has_many :products_vmes
  has_many :vmes, through: :products_vmes

  scope :actives, -> {where("status is true")}
  scope :not_deleted, -> {where(deleted: [false, nil])}

  rails_admin do
    nested_set({
        max_depth: 15,
        toggle_fields: [:enabled],
        thumbnail_fields: [:image, :cover],
        thumbnail_size: :thumb,
        thumbnail_gem: :paperclip#, # or :carrierwave
        #scopes: [:deleted, :disabled] # filter nodes by scope
    })
  end

  # Use friendly id based on name
  friendly_id :name, use: :slugged

  def model_attribute_value
    name
  end
end


