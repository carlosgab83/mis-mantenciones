# encoding: utf-8
class HorizontalFilters < ProductFilters
  attr_accessor :by_vehicle, :by_attributes

  def initialize(params = {})
    self.category = params[:category]
    self.vehicle = params[:vehicle]
    self.client_search_input = params[:client_search_input]
    self.years = params[:years]
    proccess
  end

  private

  attr_accessor :vehicle, :category, :client_search_input, :years

  def proccess
    struct = Struct.new(:brands, :models, :years)
    self.by_vehicle = struct.new(Brand.actives.all, Model.all, years.to_a.reverse)

    attributes_ids = SearchCategorySetting.horizontal_attributes_for_category(category).pluck :id
    self.by_attributes = attributes_by_category(attributes_ids, category)
  end
end
