class PromotionDetail < BaseService

  def call
    Promotion.includes(:branches, :category, :promotion_attributes).friendly.find(params[:id])
  end

  private

end
