class ProductsFinder < BaseService

  SELECT_ALL_STR = '_select_all'

  def call
    form = initialize_search
    key = form.as_json
     Rails.cache.fetch("products_finder/#{key}", expires_in: 24.hours) do
      make_4_searches(form)
      form.horizontal_filters = prepare_horizontal_filters(params[:category], form.client_search_input, form.results, form.results0, form.results1)
      form.vertical_filters = prepare_vertical_filters(params[:category], form.client_search_input, form.results, form.results_horizontal)
      form.results = form.results.paginate(page: form.client_search_input['page'])
      form
     end
  end

  private

  def initialize_search
    form = SearchProductsForm.new({vehicle: params[:vehicle]})
    form.client_search_input = params[:client_search_input] || {}
    fix_price_range(form)
    form.category = params[:category]
    form
  end

  def make_4_searches(form)
    form.results = find_products(form.client_search_input).order(:price)

    # For show only required vertical filters
    form.results_horizontal = find_products(form.client_search_input, -1, only_horizontal = true).order(:price)

    # For show only required horizontal filters values
    form.results0 = find_products(form.client_search_input, 0).order(:price)
    form.results1 = find_products(form.client_search_input, 1).order(:price)
  end

  attr_accessor :attrs_values

  def prepare_horizontal_filters(category, client_search_input, results, results0, results1)
    HorizontalFilters.new(category: category, vehicle: params[:vehicle], years: SearchCategorySetting::YEARS, client_search_input: client_search_input, results: results, results0: results0, results1: results1)
  end

  def prepare_vertical_filters(category, client_search_input, results, results_horizontal)
    VerticalFilters.new(category: category, vehicle: params[:vehicle], client_search_input: client_search_input, results: results, results_horizontal: results_horizontal)
  end

  def find_products(input, attributes_to_keep = -1, only_horizontal = false) # -1 to keep all attributes
    input['horizontal_filters'] ||= {} # initalize to empty hash in case of horizontal_filters is nil
    input['vertical_filters']   ||= {} # initalize to empty hash in case of vertical_filters is nil
    case input['horizontal_filters'].keys.first
      when 'by_attributes'
        vertical_filters = input['vertical_filters']['attributes'] || []
        vertical_filters = [] if only_horizontal
        # Deprecation on Rails 5.1
        find_products_by_attributes(input['horizontal_filters']['by_attributes'].to_a[0..attributes_to_keep].to_h, vertical_filters, params[:category])
      else # When nothing passed
        Product.actives.not_deleted.by_category(params[:category])
    end
  end

  def find_products_by_attributes(attributes, vertical_filters, category)
    products = Product.actives.not_deleted.by_category(category)
    vertical_filters.each do |attribute_id, _values|
      vertical_filters[attribute_id] ||= []
      vertical_filters[attribute_id] = [] if vertical_filters[attribute_id].include?(ProductsFinder::SELECT_ALL_STR)
    end
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

    # all_attributes => i.e:  [["22", "102V"], ["22", "103V"], ["26", "140"], ["_price_from", ""], ["_price_to", ""]]
    all_attributes = all_attributes.group_by{|attr_hash| attr_hash[0]} # attr_hash[0] is attribute_id

    # now all_attribues => {"22"=>[["22", "102V"], ["22", "103V"]], "26"=>[["26", "140"]], "_price_from"=>[["_price_from", ""]], "_price_to"=>[["_price_to", ""]]}

    # Each iteration make a distinct query, finally run an intersect query with whole previous
    all_attributes.each do |attr_id, array| # attr_id => "22", array => [["22", "102V"], ["22", "103V"]]
      attribute_id, attribute_values = attr_id, array.map{|x| x[1]} # extract only values

      next if attribute_values.size == 1 and attribute_values.first.blank?
      products = Product.actives.not_deleted.by_category(category)

      if attribute_id == "_price_from"
        products = products.where("products.price >= ?", attribute_values.first.try(:to_f)).to_sql
      elsif attribute_id == "_price_to"
        products = products.where("products.price <= ?", attribute_values.first.try(:to_f)).to_sql
      else
        attribute_values.delete('')
        attribute_values.delete(' ')
        attribute_values.map!{|x| "'#{x}'"}
        products = products.joins(:product_attributes)
                           .where("attributes_products.attribute_id = ? and attributes_products.value in (#{attribute_values.join(',')})", attribute_id.to_i).to_sql
      end
      queries << products
    end
    queries.any? ? Product.from("(#{queries.join(' intersect ')}) as products") : Product.actives.not_deleted.by_category(category)
  end

  def fix_price_range(form)
    if form.client_search_input['vertical_filters'].present? and
      form.client_search_input['vertical_filters']['attributes'].present? and
      form.client_search_input['vertical_filters']['attributes']['_price_from'].present? and
      form.client_search_input['vertical_filters']['attributes']['_price_to'].present? and
      form.client_search_input['vertical_filters']['attributes']['_price_from'].first != '' and
      form.client_search_input['vertical_filters']['attributes']['_price_to'].first != '' and
      form.client_search_input['vertical_filters']['attributes']['_price_to'].first.to_f < form.client_search_input['vertical_filters']['attributes']['_price_from'].first.to_f

      tmp = form.client_search_input['vertical_filters']['attributes']['_price_to']
      form.client_search_input['vertical_filters']['attributes']['_price_to'] = form.client_search_input['vertical_filters']['attributes']['_price_from']
      form.client_search_input['vertical_filters']['attributes']['_price_from'] = tmp
    end
  end
end
