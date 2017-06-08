class SearchBranchesForm < BaseForm

  attr_accessor :latitude, :longitude, :location_text, :brand_id, :model_id, :patent, :kms

  def latitude
    @latitude ||= params['latitude']
  end

  def longitude
    @longitude ||= params['longitude']
  end

  def location_text
    @location_text ||= params['location_text']
  end

  def brand_id
    @brand_id ||= -> {params['brand_id'].blank? or params['brand_id'].try(:to_i) == 0 ? nil : params['brand_id'].to_i}.call
  end

  def model_id
    @model_id ||= -> {params['model_id'].blank? or params['model_id'].try(:to_i) == 0 ? nil : params['model_id'].to_i}.call
  end

  def patent
    @patent ||= params['patent'].try(:upcase)
  end

  def kms
    @kms ||= params['kms'].try(:delete, '.')
  end

  def basic_search?
    brand_id or model_id
  end

  def advanced_search?
    patent or kms
  end

  def empty_search?
    not basic_search? and not advanced_search?
  end

end