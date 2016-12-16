class ProductDetail < BaseService

  def call
    product = Product.includes(:branches, :category, :product_attributes, :branches_products).friendly.find(params[:id])
  end

  private

end
