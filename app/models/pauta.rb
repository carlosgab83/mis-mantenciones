class Pauta < ApplicationRecord
  self.table_name = 'pauta'
  self.primary_key = 'id_pauta'

  has_many :pauta_details, foreign_key: :id_pauta
  has_many :manteinance_items, through: :pauta_details
  belongs_to :vme

  default_scope {where(deleted: [false, nil])}

  include ActionView::Helpers::NumberHelper
  include PautaSerializer

  def destroy
    self.deleted = true
    save
  end

  def is_generic?
    vme_id.nil?
  end

  def name
    "#{pauta_descripcion} #{humanize_kms} kms"
  end

  def humanize_kms
    number_to_currency(kilometraje, precision: 0,  delimiter: '.', format:"%n")
  end

  def engine_manteinance_items
    @engine_manteinance_items ||= manteinance_items_joins('MOTOR')
  end

  def transmission_manteinance_items
    @transmission_manteinance_items ||= manteinance_items_joins('TRANSMISION')
  end

  def brake_manteinance_items
    @brake_manteinance_items ||= manteinance_items_joins('FRENOS')
  end

  def tyres_manteinance_items
    @tyres_manteinance_items ||= manteinance_items_joins('NEUMÁTICOS')
  end

  def direction_manteinance_items
    @direction_manteinance_items ||= manteinance_items_joins('DIRECCION')
  end

  def suspension_manteinance_items
    @suspenssion_manteinance_items ||= manteinance_items_joins('SUSPENSION')
  end

  def electric_manteinance_items
    @electric_manteinance_items ||= manteinance_items_joins('ELECTRICO')
  end

  def other_manteinance_items
    @other_manteinance_items ||= manteinance_items_joins('OTROS')
  end

  private

  def manteinance_items_joins(section_type_name)
    (@array_manteinance_items ||= manteinance_items.includes(:section_type).joins(:section_type)).to_a.select do |mi|
      mi.section_type.descripcion == section_type_name
    end
  end
end
