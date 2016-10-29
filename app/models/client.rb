class Client < ApplicationRecord
  validates :name, :email, :comune_id, presence: true

  belongs_to :comune
end
