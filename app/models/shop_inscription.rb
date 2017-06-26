class ShopInscription < ApplicationRecord
  validates :name, :company_name, presence: true

  belongs_to :comune

  attr_accessor :accept_terms

  include ShopInscriptionSerializer

  def full_name
    "#{name} #{primary_last_name}"
  end
end
