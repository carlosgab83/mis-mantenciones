module HomeHelper
  def manteinance_item_status_class(relation)
    "disabled" unless relation.any?
  end

  def manteinance_items_list(manteinance_items)
    manteinance_items.collect do |manteinance_item|
      manteinance_item.desc_mantencion
    end.join("<br class='tooltip-separator'/>")
  end

  def google_map_indications_url(address)
    if address
      return "https://www.google.com/maps/dir/Current+Location/#{address.gsub(' ','+')}"
    end
    ""
  end
end
