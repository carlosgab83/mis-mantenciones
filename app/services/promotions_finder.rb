class PromotionsFinder < BaseService

  def call
    promotions = Promotion.availables.actives.not_blog
    .includes(:branches, :category, attributes_promotions: :promotion_attribute)
    .where("promotions.type <> 'BranchInformation'")
    .order("promotions.priority desc, promotions.promo_price asc, promotions.created_at desc")
    if params[:category_id]
      promotions = promotions.where(category_id: params[:category_id])
    end
    promotions
  end

  def blog_call
    promotions = Promotion.availables.actives.blog
    .includes(:branches, :category, attributes_promotions: :promotion_attribute)
    .where("promotions.type <> 'BranchInformation'")
    .order("promotions.priority desc, promotions.promo_price asc, promotions.created_at desc")
    promotions
  end
end
