# encoding: utf-8

class ManteinanceItemsCreatorForMailer < BaseService

  def call
    self.pauta = params[:pauta]
    section_types_object = create_section_types_struct(pauta)
    to_html(section_types_object)
  end

  private

  attr_accessor :pauta

  def to_html(section_types_object)
    section_types_html = ''
    section_types_object.each do |section_type_node|
      next if section_type_node[:manteinance_items].empty?
      part1 = "
        <ul style='float:left; width: 40%; font-family:open sans,helvetica neue,helvetica,arial,sans-serif;'>
          <li><span style='font-size:18px'><span style='color:#696969'><strong>#{section_type_node[:section_type].descripcion}:</strong></span></span>
          <ul>
      "

      manteinance_items_parts = ""
      section_type_node[:manteinance_items].each do |manteinance_item|
        manteinance_items_parts += "
          <li><span style='font-size:18px font-family:open sans,helvetica neue,helvetica,arial,sans-serif'><span style='color:#696969'>#{manteinance_item.desc_mantencion}</span></span></li>
        "
      end
      part2 = "
          </ul>
          </li>
        </ul>
      "
      section_types_html += part1 + manteinance_items_parts + part2
    end
    section_types_html
  end

  def create_section_types_struct(pauta)
    section_types = []
    pauta.manteinance_items.includes(:section_type).joins(:section_type).each do |manteinance_item|
      section_type_node = section_types.select{|s| s[:section_type] == manteinance_item.section_type}.first
      if section_type_node.nil?
        section_types << {section_type: manteinance_item.section_type, manteinance_items: []}
        section_type_node = section_types.last
      end
      section_type_node[:manteinance_items] << manteinance_item
    end
    section_types.sort{|a, b| a[:manteinance_items].size <=> b[:manteinance_items].size}
  end
end
