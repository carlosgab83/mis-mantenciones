module BranchPlanManager
  class Base

  PRODUCTS_LIMIT = 3

    attr_reader :branch

    def initialize(params = {})
      self.branch = params[:branch]
      return branch_plan_class
    end

    def branch_plan_instance
      branch_plan_class.new(branch: branch)
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
