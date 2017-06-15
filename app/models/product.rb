class Product < ApplicationRecord
  extend FriendlyId
  include ProductSerializer
  extend ProductsSerializer

   self.per_page = 5

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
  scope :by_category, -> (category) {joins(:category).where("products.category_id = ?", category.id)}

  def branches_products_with_prices
    non_price_value = 9999999999
    branches_products.sort{|a,b| (a.price || non_price_value) <=> (b.price || non_price_value) }
  end

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

  def min_price
    branches_products.map{|bp| bp.price }.compact.try(:min)
  end
end


