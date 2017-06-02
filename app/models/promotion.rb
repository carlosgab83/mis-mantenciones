class Promotion < ApplicationRecord

  # Class Promotion was refactorized when client request for reutilize
  # table promotions to store [OtherPromotions, BranchInformation and Manteinance].
  # Since, a promotions concept already used, Promotion go to parent and [OtherPromotions, BranchInformation and Manteinance]
  # form a STI.

  # You can do BrnachInformation.last.branches_promotions or
  # Manteinance.promotions_vmes, etc...

  extend FriendlyId
  include PromotionSerializer

  belongs_to :category
  has_many :branches_promotions, foreign_key: :promotion_id
  has_many :branches, through: :branches_promotions
  has_many :attributes_promotions, foreign_key: :promotion_id
  has_many :promotion_attributes, through: :attributes_promotions
  has_many :promotions_vmes, foreign_key: :promotion_id
  has_many :vmes, through: :promotions_vmes

  scope :availables, -> {where("? between from_date and to_date", Date.today)}
  scope :actives, -> {where("status is true")}
  scope :with_stock, -> {where("max_coupons IS NULL or max_coupons >= 1")}
  scope :not_deleted, -> {where(deleted: [false, nil])}

  # Use friendly id based on name
  friendly_id :name, use: :slugged

  # Types for concepts of re-utilization of this model
  TYPES = ['OhterPromotion', 'BranchInformation', 'Manteinance']

  def shops_details
    branches.collect do |b|
      "#{b.shop.name} (#{b.name})"
    end.join(', ')
  end

  def show_button?
    promo_price != -999
  end

end
