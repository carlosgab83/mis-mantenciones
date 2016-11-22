class ProductDetail < BaseService

  def call
    Product.includes(:branches, :category, :product_attributes).where(id: params[:id]).first
  end

  private

end
