class BranchType < ApplicationRecord

  default_scope {where("branch_types.deleted = false or branch_types.deleted IS NULL")}
  scope :actives, -> {where("branch_types.status is true")}
end
