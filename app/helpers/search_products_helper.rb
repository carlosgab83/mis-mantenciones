module SearchProductsHelper

  def vehicle_tab_active?(search_products_form)
    not search_products_form.client_search_input['horizontal_filters']['by_attributes'].present?
  end

  # Only show values that correspond with current combination
  def fill_horizontal_options_for_select(values, attribute_id, search_products_form)
    category = search_products_form.category
    attributes = SearchCategorySetting.horizontal_attributes_for_category(category).to_a
    return values.sort if attribute_id == attributes.first.id
    if attribute_id == attributes[1].id
      the_values = search_products_form.horizontal_filters.attrs_values0.map{|x|x[1]}
      return (the_values.any? ? the_values.sort : [(search_products_form.client_search_input['horizontal_filters']['by_attributes']||{}).values[1]] || [])
    end

    if attribute_id == attributes[2].id
      the_values = search_products_form.horizontal_filters.attrs_values1.map{|x|x[1]}
      return (the_values.any? ? the_values.sort : [(search_products_form.client_search_input['horizontal_filters']['by_attributes']||{}).values[2]] || [])
    end
  end

  def verify_all_deselected(attribute_id)
    (@search_products_form.client_search_input['vertical_filters'].try(:empty?) or
      @search_products_form.client_search_input['vertical_filters'].try(:[], 'attributes').nil? or
      @search_products_form.client_search_input['vertical_filters'].try(:[], 'attributes').try(:[], attribute_id.to_s).nil? or
      @search_products_form.client_search_input['vertical_filters'].try(:[], 'attributes').try(:[], attribute_id.to_s).try(:empty?))
  end
end
