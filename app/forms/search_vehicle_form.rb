class SearchVehicleForm < BaseForm

  attr_accessor :patent, :kms

  def patent
    @patent ||= params['patent']
  end

  def kms
    @kms ||= params['kms']
  end
end