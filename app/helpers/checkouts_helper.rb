module CheckoutsHelper
  def maximum_units(order_preparator)
    order_preparator.buyable.try(:max_coupons) || 10
  end

  def click_n_collect_enabled?(order_preparator)
    order_preparator.branch.shop.click_n_collect_enabled
  end

  def delivery_enabled?(order_preparator)
    order_preparator.branch.shop.delivery_enabled
  end
end
