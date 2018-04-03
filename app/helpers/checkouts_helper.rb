module CheckoutsHelper
  def maximum_units(order_preparator)
    order_preparator.buyable.try(:max_coupons) || 10
  end
end
