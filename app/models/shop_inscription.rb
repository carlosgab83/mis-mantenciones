class ShopInscription < ApplicationRecord
  validates :name, :email, :comune_id, :company_name, :company_rut, presence: true

  belongs_to :comune

  attr_accessor :accept_terms

  include ShopInscriptionSerializer

  def full_name
    "#{name} #{primary_last_name}"
  end
end
