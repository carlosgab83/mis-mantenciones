# encoding: utf-8
class HorizontalFilters < ProductFilters
  attr_accessor :by_vehicle, :by_attributes, :attrs_values, :attrs_values0, :attrs_values1, :results0, :results1

  def initialize(params = {})
    self.category = params[:category]
    self.vehicle = params[:vehicle]
    self.client_search_input = params[:client_search_input]
    self.years = params[:years]
    self.results = params[:results]
    self.results0 = params[:results0]
    self.results1 = params[:results1]
    proccess
  end

  private

  attr_accessor :vehicle, :category, :client_search_input, :years, :results

  def proccess
    struct = Struct.new(:brands, :models, :years)
    brand_id = (client_search_input.present? ? client_search_input['horizontal_filters']['by_vehicle'].try(:[],'brand_id') : nil)
    models = (brand_id ? Model.actives.where(id_marca: brand_id).order(:modelo_descripcion) : [])
    self.by_vehicle = struct.new(Brand.actives.order(:descripcion), models, years.to_a.reverse)

    attributes_ids = SearchCategorySetting.horizontal_attributes_for_category(category).pluck :id

    # Pair attribute_id and value, i.e: [[1, "val attr1"], [2, "10000"], [10, "MT"], [3, "aro1"], [11, "version1"], [12, "Negro"]]
    self.attrs_values = AttributesProduct.where(attribute_id: attributes_ids, product: results).map{|ap|[ap.attribute_id, ap.value]}
    self.attrs_values0 = AttributesProduct.where(attribute_id: attributes_ids[1], product: results0).map{|ap|[ap.attribute_id, ap.value]}.uniq
    self.attrs_values1 = AttributesProduct.where(attribute_id: attributes_ids[2], product: results1).map{|ap|[ap.attribute_id, ap.value]}.uniq

    self.by_attributes = attributes_by_category(attributes_ids, category, attrs_values)
  end
end
