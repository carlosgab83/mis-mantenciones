class AllPromotionsFinder < BaseService

  def call
    Promotion.availables.actives
    .includes(:branches, :category, attributes_promotions: :promotion_attribute)
    .order("promotions.created_at desc")
  end

  private

end
