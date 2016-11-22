module Carousel
  class Selector
    attr_reader :size, :objects, :categories

    def initialize(args = {})
      self.size = args[:size]
      self.objects = args[:objects].to_a
      self.categories = args[:categories].to_a
      self.roots = {}
      initialize_last_indices_by_category
    end

    def items
      objects_to_return = []
      self.objects_size = objects.size
      size.times do |index|
        category_id = categories[circular_index(index)].id
        begin_search_index = last_indices_by_category[category_id]
        item = next_item(category_id, begin_search_index)
        objects_to_return << item
      end
      objects_to_return.uniq.compact
    end

    private

    attr_reader :last_indices_by_category, :objects_size, :roots
    attr_writer :size, :objects, :categories, :last_indices_by_category, :objects_size, :roots

    def next_item(category_id, begin_search_index)
      for i in begin_search_index..(objects_size-1)

        if category_roots(objects[i].category_id) == category_id
          last_indices_by_category[category_id] = i + 1
          return objects[i]
        end
      end

      return nil
    end

    def circular_index(index)
      index % categories.size
    end

    def initialize_last_indices_by_category
      self.last_indices_by_category = {}
      categories.each do |category|
        last_indices_by_category[category.id] = 0
      end
    end

    def category_roots(category_id)
      roots[category_id] ||= Category.find(category_id).root.id
    end

  end
end
