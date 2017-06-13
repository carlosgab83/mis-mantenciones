class PromotionsFinder < BaseService

  def call
    promotions = Promotion.availables.actives
    .includes(:branches, :category, attributes_promotions: :promotion_attribute)
    .where("promotions.type <> 'BranchInformation'")
    .order("promotions.priority desc, promotions.promo_price asc, promotions.created_at desc")
    if params[:category_id]
      promotions = promotions.where(category_id: params[:category_id])
    end
    promotions
  end
end