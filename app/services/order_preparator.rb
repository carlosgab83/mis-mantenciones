class OrderPreparator < BaseService

  attr_reader :branch, :client, :product, :promotion, :order, :branches_product, :branches_promotion, :branches_promotions

  def call
    self.client = client
    self.branch = Branch.where(id: params[:branch_id]).first
    self.product = Product.where(id: params[:product_id]).first
    self.promotion = Promotion.where(id: params[:promotion_id]).first

    if product
      self.branches_product = product.branches_products.where(branch_id: branch.id).first
    end

    if promotion
      self.branches_promotions = promotion.branches_promotions
      self.branches_promotion = branches_promotions.first
    end

    fill_order
    self
  end

  def buyable
    product || promotion
  end

  def buyable_tupple_record
    if product
      branches_product
    elsif promotion
      branches_promotion
    end
  end

  private

  attr_writer :branch, :client, :product, :promotion, :order, :branches_product, :branches_promotion, :branches_promotions

  def fill_order
    self.order = Order.new
    add_client_data
    order
  end

  def add_client_data
    if client
      self.order.email = client.email
      self.order.rut = client.rut
      self.order.name = client.name
      self.order.nameprimary_last_name = client.primary_last_name
      self.order.phone = client.phone
      self.order.commune_id = client.comune_id
      self.order.street_address = client.street_address
      self.order.number_address = client.number_address
      self.order.region = client.region
    end
  end
end
