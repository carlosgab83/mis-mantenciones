module BranchPlanManager
  class Base

  PRODUCTS_LIMIT = 3
  PROMOTIONS_LIMIT = 3

    attr_reader :branch

    def initialize(params = {})
      self.branch = params[:branch]
      return branch_plan_class
    end

    def branch_plan_instance
      branch_plan_class.new(branch: branch)
    end

    protected

    def branch_information_relation
      branch.promotions.where(type: 'BranchInformation')
    end

    def branch_products
      if products_categories_ids.any?
        actives_products_ids = Product.actives.not_deleted.pluck :id
        products_count = branch.products
          .where("products.category_id in (#{products_categories_ids.join(',')})")
          .where("products.id in (?)", actives_products_ids)
      end
    end

    def products_categories_ids
      # This branch has products?, then show all products
      @products_categories_ids ||= -> {
        products_category = Category.roots.where(name: 'Productos').first
        products_categories_ids = products_category.self_and_descendants.pluck :id
      }.call
    end

    private

    attr_accessor :branch

    def branch_plan_class
      case branch.plan.try(:name)
        when 'Plan 1'
          BranchPlan1
        when 'Plan 2'
          BranchPlan2
        when 'Plan 3'
          BranchPlan3
        when 'Plan 4'
          BranchPlan4
        else
          BranchPlan1
      end
    end
  end
end
