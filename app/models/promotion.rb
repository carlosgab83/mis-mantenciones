class Promotion < ApplicationRecord
  belongs_to :category
  has_many :branches_promotions
  has_many :branches, through: :branches_promotions
  has_many :attributes_promotions
  has_many :promotion_attributes, through: :attributes_promotions
  has_many :promotions_vmes
  has_many :vmes, through: :promotions_vmes

  scope :availables, -> {where("? between from_date and to_date", Date.today)}
  scope :actives, -> {where("status = true")}
  scope :not_deleted, -> {where(deleted: [false, nil])}
end
