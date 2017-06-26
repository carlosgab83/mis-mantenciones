class Brand < ApplicationRecord
  self.table_name = "marca"

  scope :actives, -> {where("marca_estado = 1")}

  include BrandSerializer
end
