class Promotion < ApplicationRecord

  # Class Promotion was refactorized when client request for reutilize
  # table promotions to store [OtherPromotion, BranchInformation and Manteinance].
  # Since, a promotions concept already used, Promotion go to parent and [OtherPromotion, BranchInformation and Manteinance]
  # form a STI.

  # You can do BrnachInformation.last.branches_promotions or
  # Manteinance.promotions_vmes, etc...

  extend FriendlyId
  include PromotionSerializer
  extend PromotionsSerializer
  include MicrodataGenerator

  belongs_to :category
  has_many :branches_promotions, foreign_key: :promotion_id
  has_many :branches, through: :branches_promotions
  has_many :attributes_promotions, foreign_key: :promotion_id
  has_many :promotion_attributes, through: :attributes_promotions
  has_many :promotions_vmes, foreign_key: :promotion_id
  has_many :vmes, through: :promotions_vmes
  has_many :shops, through: :branches

  scope :availables, -> {where("? between from_date and to_date", Date.today)}
  scope :actives, -> {where("status is true")}
  scope :with_stock, -> {where("max_coupons IS NULL or max_coupons >= 1")}
  scope :not_deleted, -> {where(deleted: [false, nil])}
  scope :not_blog, -> {joins(:category).where("categories.name <> 'Blog'")}
  scope :blog, -> {joins(:category).where("categories.name = 'Blog'")}

  # Use friendly id based on name
  friendly_id :name, use: :slugged

  # Types for concepts of re-utilization of this model
  TYPES = ['OhterPromotion', 'BranchInformation', 'Manteinance']

  # Validations
  validates :priority, :image_url, :name, :description, :from_date, :to_date, presence: true

  def shops_details
    branches.first.try(:shop).try(:name)
  end

  def show_button?
    promo_price != -999
  end

  def first_branch
    branches.first
  end

  def first_shop
    first_branch.try(:shop)
  end

  def before_registration_text
    "#{category.promotion_before_registration_text} #{name}, disponible en"
  end

  def confirmed_text
    "#{category.promotion_confirmed_text} #{promotion.name}"
  end

  def done_text(coupon)
    if category.vehicle?
      category.promotion_done_vehicle_text
    else
      category.promotion_done_text(coupon)
    end
  end

  def branches_promotions_with_prices
    non_price_value = 9999999999
    branches_promotions.sort{|a,b| (a.price || non_price_value) <=> (b.price || non_price_value) }
  end
end
