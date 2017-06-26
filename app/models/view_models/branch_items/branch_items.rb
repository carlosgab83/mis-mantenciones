class BranchItems

  attr_accessor :branch_items
  attr_reader :information, :promotions, :manteinances, :categories, :show_info_button

  def initialize(params = {})
    self.branch_items = params[:branch_items]
    self.information = nil
    self.promotions = []
    self.manteinances = []
    self.categories = []
    self.show_info_button = (params[:branch_items].try(:[], :show_info_button) != false)
    fill_object
  end

  private

  attr_writer :information, :promotions, :manteinances, :categories, :show_info_button

  def fill_object
    fill_promotions
    fill_products
  end

  def fill_promotions
    branch_items[:promotions].each do |promotion|
      if promotion.is_a? BranchInformation
        self.information = promotion
      elsif promotion.is_a? OtherPromotion
        self.promotions << promotion
      elsif promotion.is_a? Manteinance
        self.manteinances << promotion
      end
    end
  end

  def fill_products
    # This hash is or performance purposes while fill categories object
    product_category_hash = {}

    struct = Struct.new(:id, :name, :products)

    branch_items[:products].each do |product|
      position = -1
      if product_category_hash[product.category_id].present?
        position = product_category_hash[product.category_id]
      else
        position = @categories.size # next position on array
        product_category_hash[product.category_id] = position
        @categories[position] = struct.new(product.category.id, product.category.name, [])
      end
      @categories[position].products << product
    end
  end
end