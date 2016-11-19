module HomeHelper
  def manteinance_item_status_class(relation)
    "disabled" unless relation.any?
  end
end
