class CartItem < ApplicationRecord
  belongs_to :buyable, polymorphic: true
end
