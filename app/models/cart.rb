class Cart < ApplicationRecord
  validates :client_id, :price, presence: true

  belongs_to :client
  has_many :cart_items
end
