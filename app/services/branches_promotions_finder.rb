class BranchesPromotionsFinder < PromotionsFinder

  def call
    PromotionsFinder.new(params).call.joins(:branches).where("branches.slug = ?", params[:branch_id])
  end
end
