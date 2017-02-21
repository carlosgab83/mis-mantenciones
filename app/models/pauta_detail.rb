class PautaDetail < ApplicationRecord
  self.table_name = "pauta_detalle"

  belongs_to :pauta, foreign_key: :id_pauta
  belongs_to :manteinance_item, foreign_key: :id_item_mantencion
  belongs_to :section_type, foreign_key: :id_tipo_seccion
end
