class ProductsFinder < BaseService

  def call
    form = SearchProductsForm.new({})
    form.client_search_input = params[:client_search_input] || {}
    form.horizontal_filters = prepare_horizontal_filters(params[:category], form.client_search_input)
    form.vertical_filters = prepare_vertical_filters(params[:category], form.client_search_input)
    form.results = find_products(form.client_search_input).order(:price).paginate(page: form.client_search_input['page'])
    form
  end

  private

  def prepare_horizontal_filters(category, client_search_input)
    HorizontalFilters.new(category: category, vehicle: @vehicle, years: SearchCategorySetting::YEARS, client_search_input: client_search_input)
  end

  def prepare_vertical_filters(category, client_search_input)
    VerticalFilters.new(category: category, vehicle: @vehicle, client_search_input: client_search_input)
  end

  def find_products(input)
    input['horizontal_filters'] ||= {} # initalize to empty hash in case of horizontal_filters is nil
    input['vertical_filters']   ||= {} # initalize to empty hash in case of vertical_filters is nil
    case input['horizontal_filters'].keys.first
      when 'by_attributes'
        find_products_by_attributes(input['horizontal_filters']['by_attributes'], input['vertical_filters']['attributes'] || [], params[:category])
      when 'by_vehicle'
        find_products_by_vehicle_with_vertical_filters(input['horizontal_filters']['by_vehicle'], input['vertical_filters']['attributes'], params[:category])
      else # When nothing passed
        Product.actives.not_deleted.by_category(params[:category])
    end
  end

  def find_products_by_attributes(attributes, vertical_filters, category)
    products = Product.actives.not_deleted.by_category(category)
    if (attributes.values - [""]).empty? and vertical_filters.empty?
      return products
    end

    queries = []
    # Unify horizontal attributes (tab attributes) with vertical filters: all_attributes will contain both
    all_attributes = []
    attributes.each_pair{|attribute_id, attribute_value| all_attributes << [attribute_id, attribute_value]}
    (vertical_filters || []).each do |attribute_id, attributes_values|
      attributes_values.each do |attribute_value|
        all_attributes << [attribute_id, attribute_value]
      end
    end

    # Each iteration make a distinct query, finally run an intersect query with whole previous
    all_attributes.each do |attr_id_value_array| # i.e:  [["10", "OTRO T"], ["1", ""], ["3", "aro1"]]
      attribute_id, attribute_value = attr_id_value_array[0], attr_id_value_array[1]
      next if attribute_value.blank?
      products = Product.actives.not_deleted.by_category(category)

      if attribute_id == "_price_from"
        next if attribute_value.blank?
        products = products.where("products.price >= ?", attribute_value.to_f).to_sql
      elsif attribute_id == "_price_to"
        next if attribute_value.blank?
        products = products.where("products.price <= ?", attribute_value.to_f).to_sql
      else
        products = products.joins(:product_attributes)
                           .where("attributes_products.attribute_id = ? and attributes_products.value = ?", attribute_id.to_i, attribute_value).to_sql
      end
      queries << products
    end
    queries.any? ? Product.from("(#{queries.join(' intersect ')}) as products") : Product.actives.not_deleted.by_category(category)
  end

  def find_products_by_vehicle_with_vertical_filters(by_vehicle_attributes, vertical_filters, category)
    queries = []
    queries << find_products_by_attributes({}, vertical_filters || [], category).to_sql
    queries << find_products_by_vehicle(by_vehicle_attributes, category).to_sql
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
