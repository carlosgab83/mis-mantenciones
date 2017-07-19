class BranchType < ApplicationRecord

  default_scope {where("deleted = false or deleted IS NULL")}
  scope :actives, -> {where("status is true")}
end
