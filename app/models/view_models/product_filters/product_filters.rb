# encoding: utf-8
class ProductFilters

  def attributes_by_category(attributes_ids, category, attrs_values)
    struct = Struct.new(:attribute, :values)
    attributes_and_values_list(attributes_ids, category).collect do |attribute_hash|
      struct.new(attribute_hash[:attribute], attribute_hash[:values].sort)
    end
  end

  def attributes_and_values_list(attributes_ids, category)
    attributes_products = Attribute.attributes_products_for_attributes_ids_and_category(attributes_ids, category)
    result = {}
    attributes_products.each do |attributes_product|
      result[attributes_product.product_attribute] ||= []
      if not result[attributes_product.product_attribute].include?(attributes_product.value)
        result[attributes_product.product_attribute] << attributes_product.value
      end
    end
    sort(result, attributes_ids)
  end

  # Sorts attributes list based on SearchCategorySetting config table (field: position)
  def sort(result, attributes_ids)
    result.keys
    attributes_ids.collect do |attribute_id|
      key = result.keys.select{|key| key.id == attribute_id}.first
      {attribute: key, values: result[key]}
    end
  end
end
