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

  NO_BUTTON = 0
  MISMANTENCIONES_CHECKOUT = 1
  REGULAR_MODAL = 2
  INFO_MODAL = 3

  # Use friendly id based on name
  friendly_id :name, use: :slugged

  # Types for concepts of re-utilization of this model
  TYPES = ['OhterPromotion', 'BranchInformation', 'Manteinance']

  # Validations
  validates :priority, :image_url, :name, :description, :from_date, :to_date, :button_type, presence: true

  def shops_details
    branches.first.try(:shop).try(:name)
  end

  def show_button?
    button_type != NO_BUTTON
  end

  def regular_modal?
    button_type == REGULAR_MODAL
  end

  def info_modal?
    button_type == INFO_MODAL
  end

  def mm_checkout?
    button_type == MISMANTENCIONES_CHECKOUT
  end

  def first_branch
    branches.first
  end

  def first_shop
    first_branch.try(:shop)
  end

  def branches_promotions_with_prices
    non_price_value = 9999999999
    branches_promotions.sort{|a,b| (a.price || non_price_value) <=> (b.price || non_price_value) }
  end

  # Read automatically by rails_admin
  def button_type_enum
    [
      ['Sin botón', NO_BUTTON],
      ['Ir al checkout de Mismantenciones.com', MISMANTENCIONES_CHECKOUT],
      ['Obtener Cupon', REGULAR_MODAL],
      ['Obtener Información', INFO_MODAL]
    ]
  end

  # TO DO: Refactor following logic to apply texts: Maybe move to a module and send texts to locales.

  def before_registration_text
    text = if regular_modal?
      'Te enviaremos un Cupón de Descuento para el servicio'
    else
      'Estás solicitando información de'
    end
    "#{text} #{name}, disponible en"
  end

  def done_text(coupon)
    if regular_modal?
      "Tu número de cupón es: #{coupon.id} para la promoción #{coupon.promotion.name}"
    else # info_modal
      "Te enviaremos un correo electrónico con más información de este modelo"
    end
  end
end
