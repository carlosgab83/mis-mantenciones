module BranchPlanManager
  class BranchPlan2 < Base

    def items
      {promotions: branch_information_relation + generic_promotions, products: branch_products}
    end
  end
end
