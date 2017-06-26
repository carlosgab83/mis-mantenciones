class Model < ApplicationRecord
  self.table_name = "modelo"

  belongs_to :brand, foreign_key: :id_marca

  scope :actives, -> {where("modelo_estado = 1")}

  include ModelSerializer
end
