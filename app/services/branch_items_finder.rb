class BranchItemsFinder < BaseService

  def call
    return [] unless branch
    _branch_items_raw = BranchPlanManager::Base.new(branch: branch, user_input: user_input).branch_plan_instance.items
    BranchItems.new(branch_items: _branch_items_raw)
  end

  private

  def branch
    @branch ||= params[:branch]
  end

  def user_input
    @user_input ||= params[:form]
  end

end
