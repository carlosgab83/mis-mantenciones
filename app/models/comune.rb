class Comune < ApplicationRecord
  self.table_name = "comuna"

  belongs_to :region
end
