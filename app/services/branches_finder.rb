class BranchesFinder < BaseService

  def call
    # for now, retreive all branches with plan (dev purposes)
    Branch.where.not(plan_id: nil)
  end

  private


end
