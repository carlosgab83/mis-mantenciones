class OrderCreator < BaseService

  attr_reader :client, :cart, :order

  def call
    self.client = create_client
    self.cart = create_cart
    create_cart_items
    update_cart_price
    self.order = create_order
    self
  end

  private

  attr_reader :branch_id
  attr_writer :client, :cart, :order, :branch_id

  def create_client
    ClientCreator.new(
      email: params[:email],
      rut: params[:rut],
      name: params[:name],
      primary_last_name: params[:primary_last_name],
      phone: params[:phone],
      street_address: params[:street_address],
      number_address: params[:number_address],
      region: params[:region],
      comune_id: params[:commune_id]
    ).call
  end

  def create_cart
    # Creating a cart with price 0 for now. It will be updated after creation of cart_items
    cart = Cart.create(client_id: client.id, price: 0)
  end

  def update_cart_price
    cart.price = cart.cart_items.map{|ci| ci.unit_price * ci.quantity}.reduce(:+)
    cart.save
  end

  def create_cart_items
    params[:buyables].collect do |buyable_params|
      buyable = buyable_params[:branch_tupple_record_class].constantize.find(buyable_params[:branch_tupple_record_id])
      self.branch_id = buyable.branch_id
      CartItem.create(
        buyable: buyable,
        unit_price: buyable.price,
        quantity: buyable_params[:quantity],
        cart_id: cart.id
      )
    end
  end

  def create_order
    Order.create(
      email: client.email,
      rut: client.rut,
      name: client.name,
      primary_last_name: client.primary_last_name,
      phone: client.phone,
      street_address: client.street_address,
      number_address: client.number_address,
      region: client.region,
      commune_id: client.comune_id,
      contact_seller: params[:contact_seller],
      full_name: params[:full_name],
      contact_phone: params[:contact_phone],
      accept_terms: params[:accept_terms],
      status: :pending,
      client_id: client.id,
      cart_id: cart.id,
      branch_id: branch_id,
    )
  end
end
