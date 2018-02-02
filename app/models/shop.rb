class Shop < ApplicationRecord

  extend FriendlyId

  # Use friendly id based on name
  friendly_id :name, use: :slugged

  has_many :branches
end
