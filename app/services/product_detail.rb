class ProductDetail < BaseService

  def call
    product = Product.includes(:branches, :category, :product_attributes, :branches_products).where(id: params[:id]).first
  end

  private

end
