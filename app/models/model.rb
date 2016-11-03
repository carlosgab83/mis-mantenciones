class Model < ApplicationRecord
  self.table_name = "modelo"

  belongs_to :brand, foreign_key: :id_marca
end
