module BranchPlanManager
  class BranchPlan2 < Base

    def items
      branch_information = branch_information_relation
      promotions = OtherPromotion.availables.actives.with_stock.not_deleted
        .joins(branches_promotions: :branch)
        .where("branches.id = ?", branch.id)
        .order("promotions.priority desc, promotions.promo_price asc, promotions.created_at desc")
        .limit(PROMOTIONS_LIMIT)

      {promotions: branch_information + promotions, products: branch_products}
    end
  end
end
