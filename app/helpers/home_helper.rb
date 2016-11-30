module HomeHelper
  def manteinance_item_status_class(relation)
    "disabled" unless relation.any?
  end

  def manteinance_items_list(manteinance_items)
    manteinance_items.collect do |manteinance_item|
      manteinance_item.desc_mantencion
    end.join('<br/>')
  end
end
