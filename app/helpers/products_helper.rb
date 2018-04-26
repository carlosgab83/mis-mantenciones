module ProductsHelper

  def show_buy_button?(product)
    product.branches_products_with_prices.select{|bp| bp.mismantenciones_checkout?}.any?
  end
end
