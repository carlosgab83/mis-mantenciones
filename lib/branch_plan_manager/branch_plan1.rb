module BranchPlanManager
  class BranchPlan1 < Base

    def items
      all_products = []
      if branch_products.count > 0
        all_products = Product.actives.not_deleted.includes(:category).where(category_id: products_categories_ids).limit(PRODUCTS_LIMIT)
      end

      {promotions: branch_information_relation, products: all_products, show_info_button: false}
    end
  end
end
