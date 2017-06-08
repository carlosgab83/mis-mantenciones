class PromotionDetail < BaseService

  def call
    Promotion.includes(:branches, :shops, :category, :promotion_attributes).friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    return nil
  end

  private

end
