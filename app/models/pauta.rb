class Pauta < ApplicationRecord
  self.table_name = 'pauta'
  self.primary_key = 'id_pauta'

  has_many :pauta_details, foreign_key: :id_pauta
  has_many :manteinance_items, through: :pauta_details
  belongs_to :vme

  default_scope {where(deleted: [false, nil])}

  def destroy
    self.deleted = true
    save
  end

  def is_generic?
    vme_id.nil?
  end
end
