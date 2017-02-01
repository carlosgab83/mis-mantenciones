class ProductsFinder < BaseService

  def call
    form = SearchProductsForm.new({})
    form.horizontal_filters = prepare_horizontal_filters(params[:category], params[:vehicle])
    form.vertical_filters = prepare_vertical_filters(params[:category])
    form.results = find_products(params[:client_search_input] || {})
    form
  end

  private

  def prepare_horizontal_filters(category, vehicle)
    HorizontalFilters.new(category: category, vehicle: @vehicle, years: SearchCategorySetting::YEARS)
  end

  def prepare_vertical_filters(category)
    VerticalFilters.new(category: category, vehicle: @vehicle)
  end

  def find_products(input)
    input['horizontal_filters'] ||= {} # initalize to empty hash in case of horizontal_filters is nil
    case input['horizontal_filters'].keys.first
      when 'by_attributes'
        find_products_by_attributes(input['horizontal_filters']['by_attributes'], params[:category])
      when 'by_vehicle'
        find_products_by_vehicle(input['horizontal_filters']['by_vehicle'], params[:category])
      else # When nothing passed
        Product.all # MUST PAGINATE ******#******************#*********#######
    end
  end

  def find_products_by_attributes(attributes, category)
    products = Product.actives.not_deleted.by_category(category).joins(:product_attributes)
    conditions = []
    attributes.each do |attribute_id, attribute_value|
      conditions << "(#{attribute_id_query_part(attribute_id, attribute_value)} and #{attribute_value_query_part(attribute_value)})"
    end
    products = products.where("#{conditions.join(' and ')}")
    products
  end

  def attribute_id_query_part(attribute_id, attribute_value)
    attribute_value.present? ? "attributes_products.attribute_id = #{attribute_id}" : '1=1'
  end

  def attribute_value_query_part(attribute_value)
    attribute_value.present? ? "attributes_products.value = '#{attribute_value}'" : '1=1'
  end

  def find_products_by_vehicle(attributes, category)
    [] # For now....
  end

end
