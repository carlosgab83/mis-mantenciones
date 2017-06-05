module BranchPlanManager
  class BranchPlan1 < Base

    def items
      promotions = branch.promotions.where(type: 'BranchInformation')

      # This branch has products?, then show all products
      products_category = Category.roots.where(name: 'Productos').first
      products_categories_ids = products_category.self_and_descendants.pluck :id

      products_count = 0
      if products_categories_ids.any?
        actives_products_ids = Product.actives.not_deleted.pluck :id
        products_count = branch.products
          .where("products.category_id in (#{products_categories_ids.join(',')})")
          .where("products.id in (?)", actives_products_ids).count
      end

      all_products = []
      if products_count > 0
        all_products = Product.actives.not_deleted.includes(:category).where(category_id: products_categories_ids).limit(PRODUCTS_LIMIT)
      end

      {promotions: promotions, products: all_products}
    end
  end
end
