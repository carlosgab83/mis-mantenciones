class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :client
  belongs_to :branch

  before_create :create_order_number

  def create_order_number
    begin
      self.order_number = SecureRandom.random_number(100000000).to_s.rjust(8,'0')
    end while self.class.exists?(:order_number => order_number)
  end
end
