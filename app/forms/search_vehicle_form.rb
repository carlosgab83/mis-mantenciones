class SearchVehicleForm < BaseForm

  attr_accessor :patent, :kms

  def patent
    @patent ||= params['patent'].try(:upcase)
  end

  def kms
    @kms ||= params['kms']
  end
end