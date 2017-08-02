class PromotionCategoriesFinder < BaseService

  def call
    categories = Category.joins(:promotions).uniq.leaves.not_blog

    if params[:branch]
      categories = categories.joins(promotions: :branches).where('branches.id = ?', params[:branch].id)
    end
    categories
  end
end
