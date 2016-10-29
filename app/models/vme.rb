class Vme < ApplicationRecord
  self.table_name = "vehiculo_modelo_especifico"

  belongs_to :model, foreign_key: :id_modelo
  has_many :promotions_vmes
  has_many :promotions, through: :promotions_vmes
end
