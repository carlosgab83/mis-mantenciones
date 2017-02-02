module SearchProductsHelper

  def vehicle_tab_active?(search_products_form)
    not search_products_form.client_search_input['horizontal_filters']['by_attributes'].present?
  end
end
