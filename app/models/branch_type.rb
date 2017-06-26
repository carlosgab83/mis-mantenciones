class BranchType < ApplicationRecord

  default_scope {where("deleted = false or deleted IS NULL")}
end
