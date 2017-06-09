module BranchPlanManager
  class Base

  PRODUCTS_LIMIT = 3
  PROMOTIONS_LIMIT = 3

    attr_reader :branch, :user_input

    def initialize(params = {})
      self.branch = params[:branch]
      self.user_input = params[:user_input]
      return branch_plan_class
    end

    def branch_plan_instance
      branch_plan_class.new(branch: branch, user_input: user_input)
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

    def generic_promotions
      generic_promotions = OtherPromotion.availables.actives.with_stock.not_deleted
        .joins(branches_promotions: :branch)
        .where("branches.id = ?", branch.id)
        .order("promotions.priority desc, promotions.promo_price asc, promotions.created_at desc")
    end

    private

    attr_writer :branch, :user_input

    def branch_plan_class
      case branch.plan.try(:name)
        when Plan::PLAN1
          BranchPlan1
        when Plan::PLAN2
          BranchPlan2
        when Plan::PLAN3
          BranchPlan3
        when Plan::PLAN4
          BranchPlan4
        else
          BranchPlan1
      end
    end
  end
end
