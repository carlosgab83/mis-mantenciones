class Client < ApplicationRecord
  validates :name, :email, presence: true

  belongs_to :comune

  include ClientSerializer

  def full_name
    "#{name} #{primary_last_name}"
  end
end
