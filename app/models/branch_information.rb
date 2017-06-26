class BranchInformation < Promotion

  def before_registration_text
    " Introduce tus datos para que seas contactado por"
  end

  def done_text(_coupon)
    " Te enviaremos un correo electrónico con más información de este taller."
  end
end
