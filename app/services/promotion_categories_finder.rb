class PromotionCategoriesFinder < BaseService

  def call
    Category.joins(:promotions).uniq.leaves
  end
end
