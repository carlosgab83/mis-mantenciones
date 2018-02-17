class Payment < ApplicationRecord
  include PaymentSerializer

  belongs_to :order

end
