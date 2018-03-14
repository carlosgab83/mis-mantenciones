class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :client
  belongs_to :branch

  include OrderSerializer

  before_create :create_order_number

  def create_order_number
    begin
      self.order_number = SecureRandom.random_number(100000000).to_s.rjust(8,'0')
    end while self.class.exists?(:order_number => order_number)
  end

  def buyable_items_array
    cart.cart_items.collect do |cart_item|
      {
        id: cart_item.buyable.buyable_item.id,
        name: cart_item.buyable.buyable_item.name,
        quantity: cart_item.quantity,
        unit_price: cart_item.unit_price
      }
    end
  end
end
