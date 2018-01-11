class CartItem < ApplicationRecord
  belongs_to :buyable, polymorphic: true

  def buyable_item
    buyable.buyable_item
  end
end
