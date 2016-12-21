module VehicleSerializer
  def to_event_tracker_builder
    Jbuilder.new do |json|
      json.patent                   patent
      json.kms                      kms
      json.brand_id                 brand_id
      json.brand_name               table_brand_name
      json.model_id                 model_id
      json.model_name               table_model_name
      json.manufacturing_year       manufacturing_year
      json.rvm_brand                rvm_brand
      json.rvm_model                rvm_model
      json.vme_id                   vme.try(:vme_id)
      json.vme_specific_model       vme.try(:vme_mod_especifico)
    end
  end
end