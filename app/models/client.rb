class Client < ApplicationRecord
  validates :name, :email, :phone, presence: true

  belongs_to :comune

  include ClientSerializer

  def full_name
    "#{name} #{primary_last_name}"
  end
end
