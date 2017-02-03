# encoding: utf-8
class VerticalFilters < ProductFilters
  attr_accessor :attributes

  def initialize(params = {})
    self.category = params[:category]
    self.client_search_input = params[:client_search_input]
    proccess
  end

  private

  attr_accessor :category, :client_search_input

  def proccess
    attributes_ids = SearchCategorySetting.vertical_attributes_for_category(category).pluck :id
    self.attributes = attributes_by_category(attributes_ids, category)
  end
end
