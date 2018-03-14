module CartSerializer
  def to_event_tracker_builder
    Jbuilder.new do |json|
      cart_items.each_with_index do |_, i|
        json.set!("item#{i}_id",         cart_items[i].try(:buyable).try(:buyable_item).try(:id))
        json.set!("item#{i}_name",       cart_items[i].try(:buyable).try(:buyable_item).try(:name))
        json.set!("item#{i}_quantity",   cart_items[i].quantity)
        json.set!("item#{i}_unit_price", cart_items[i].unit_price)
      end
      json.total_price price
    end
  end
end