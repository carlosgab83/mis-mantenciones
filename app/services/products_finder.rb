class ProductsFinder < BaseService

  def call
    form = SearchProductsForm.new({})
    form.horizontal_filters = prepare_horizontal_filters(params[:category], params[:vehicle])
    form.vertical_filters = prepare_vertical_filters(params[:category])
    #form.results = find_products(params[:client_search_input])
    form
  end

  private

  def prepare_horizontal_filters(category, vehicle)
    HorizontalFilters.new(category: category, vehicle: @vehicle, years: SearchCategorySetting::YEARS)
  end

  def prepare_vertical_filters(category)
    VerticalFilters.new(category: category, vehicle: @vehicle)
  end

end
