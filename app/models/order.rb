class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :client
  belongs_to :branch
  belongs_to :comune, foreign_key: :commune_id

  BRANCH_RETIREMENT = 'click-n-collect-tab'
  DELIVERY          = 'delivery-tab'

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

  def is_delivery?
    retirement_type == DELIVERY
  end

  def full_address
    "#{street_address}, #{number_address}, #{comune.desc_comuna}, región #{comune.region.name}"
  end

  def full_contact_info
    "#{contact_seller}, teléfono: #{contact_phone}"
  end

  def delivey_installation_str
    delivery_installation?  ? 'Si': 'No'
  end

  def branch_installation_str
    branch_installation?  ? 'Si': 'No'
  end
end
