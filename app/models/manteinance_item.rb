class ManteinanceItem < ApplicationRecord
  self.table_name = "item_mantencion"
  self.primary_key = :id_item_mantencion

  belongs_to :section_type, foreign_key: :id_tipo_seccion

  include ManteinanceItemSerializer
end
