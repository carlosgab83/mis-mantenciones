module ApplicationHelper
  def render_slim(slim_markup)
    Slim::Template.new { slim_markup }.render.html_safe
  end

  def mismantenciones_number_to_currency(price)
    number_to_currency(price, precision: 0,  delimiter: '.')
  end

  def mismantenciones_number_to_km(km)
    number_to_currency(km, precision: 0,  delimiter: '.', format:"%n")
  end

  def vehicle_text(vehicle, pauta)
    text = "#{vehicle.rvm_brand.upcase} #{vehicle.rvm_model.upcase}"
    variants = []
    variants << (pauta.diesel_engine ? 'Diesel' : nil)
    variants << (pauta.double_traction ? 'Doble tracción' : nil)
    variants << (pauta.automatic_transmission ? 'Automático' : nil)
    "#{text} #{variants.compact.join(', ')}."
  end
end
