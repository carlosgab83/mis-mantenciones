class Client < ApplicationRecord
  validates :name, :email, :comune_id, presence: true

  belongs_to :comune

  attr_accessor :accept_terms

  include ClientSerializer
end
