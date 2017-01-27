class Client < ApplicationRecord
  validates :name, :email, :comune_id, presence: true

  belongs_to :comune

  attr_accessor :accept_terms

  include ClientSerializer

  def full_name
    "#{name} #{primary_last_name}"
  end
end
