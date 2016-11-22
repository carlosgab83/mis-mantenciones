class PromotionDetail < BaseService

  def call
    Promotion.includes(:branches, :category, :promotion_attributes).where(id: params[:id]).first
  end

  private

end
