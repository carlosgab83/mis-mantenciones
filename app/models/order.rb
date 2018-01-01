class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :client
  belongs_to :branch
end
