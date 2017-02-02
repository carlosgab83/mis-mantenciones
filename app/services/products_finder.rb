class ProductsFinder < BaseService

  def call
    form = SearchProductsForm.new({})
    form.client_search_input = params[:client_search_input] || {}
    form.horizontal_filters = prepare_horizontal_filters(params[:category], params[:vehicle], form.client_search_input)
    form.vertical_filters = prepare_vertical_filters(params[:category])
    form.results = find_products(form.client_search_input).order(:price)
    form
  end

  private

  def prepare_horizontal_filters(category, vehicle, client_search_input)
    HorizontalFilters.new(category: category, vehicle: @vehicle, years: SearchCategorySetting::YEARS, client_search_input: client_search_input)
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
        Product.actives.not_deleted.by_category(params[:category])
    end
  end

  def find_products_by_attributes(attributes, category)
    products = Product.actives.not_deleted.by_category(category)
    if (attributes.values - [""]).empty?
      return products
    end

    queries = []
    attributes.each do |attribute_id, attribute_value|
      next if attribute_value.blank?
      products = Product.actives.not_deleted.by_category(category)
                  .joins(:product_attributes)
                  .where("attributes_products.attribute_id = ? and attributes_products.value = ?", attribute_id.to_i, attribute_value).to_sql
      queries << products
    end
    Product.from("(#{queries.join(' intersect ')}) as products")
  end

  def find_products_by_vehicle(attributes, category)
    products = Product.actives.not_deleted.by_category(Category.last)
    if attributes["brand_id"].present? or attributes["model_id"].present? or attributes["year"].present?
      products = products.joins(:products_vmes).joins(products_vmes: {vme: {model: :brand}})
    end
    if attributes["brand_id"].present?
      products = products.where("marca.id_marca = #{attributes["brand_id"]}")
    end
    if attributes["model_id"].present?
      products = products.where("modelo.id_modelo = #{attributes["model_id"]}")
    end
    if attributes["year"].present?
      products = products.where("? between coalesce(products_vmes.from_year, 0) and coalesce(products_vmes.to_year, 3000)", attributes["year"].to_i)
    end
    products
  end
end
