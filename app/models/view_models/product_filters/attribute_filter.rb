class ProductFilters::AttributeFilter
  attr_accessor :attribute, :values

  def initialize(attribute, values)
    self.attribute = attribute
    self.values = values
  end
end