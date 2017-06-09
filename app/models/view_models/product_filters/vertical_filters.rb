# encoding: utf-8
class VerticalFilters < ProductFilters
  attr_accessor :attributes, :attrs_values, :attrs_values_only_horizontal

  def initialize(params = {})
    self.category = params[:category]
    self.client_search_input = params[:client_search_input]
    self.results = params[:results]
    self.results_horizontal = params[:results_horizontal]
    proccess
  end

  private

  attr_accessor :category, :client_search_input, :results, :results_horizontal

  def proccess
    attributes_ids = SearchCategorySetting.vertical_attributes_for_category(category).pluck :id

    # Pair attribute_id and value, i.e: [[1, "val attr1"], [2, "10000"], [10, "MT"], [3, "aro1"], [11, "version1"], [12, "Negro"]]
    self.attrs_values = AttributesProduct.where(product:results).map{|ap|[ap.attribute_id, ap.value]}
    self.attrs_values_only_horizontal = AttributesProduct.where(product:results_horizontal).map{|ap|[ap.attribute_id, ap.value]}

    self.attributes = attributes_by_category(attributes_ids, category, attrs_values)
  end
end
