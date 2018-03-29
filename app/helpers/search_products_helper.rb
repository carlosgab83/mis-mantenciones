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
      i = 1
      method_name = 'attrs_values0'
      return options(search_products_form, i, method_name)
    end

    if attribute_id == attributes[2].id
      i = 2
      method_name = 'attrs_values1'
      return options(search_products_form, i, method_name)
    end
  end

  def options(search_products_form, i, method_name)
    the_values = search_products_form.horizontal_filters.send(method_name).map{|x|x[1]}
    return (the_values.any? ? the_values.sort : [(search_products_form.client_search_input['horizontal_filters']['by_attributes']||{}).values[i]] || [])
  end

  def verify_all_deselected(attribute_id)
    (@search_products_form.client_search_input['vertical_filters'].try(:empty?) or
      @search_products_form.client_search_input['vertical_filters'].try(:[], 'attributes').nil? or
      @search_products_form.client_search_input['vertical_filters'].try(:[], 'attributes').try(:[], attribute_id.to_s).nil? or
      @search_products_form.client_search_input['vertical_filters'].try(:[], 'attributes').try(:[], attribute_id.to_s).try(:empty?))
  end
end
