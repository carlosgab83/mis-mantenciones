require "ffaker"

FactoryGirl.define do

  factory :model_land_cruiser, class: Model do
    id_modelo 1
    modelo_descripcion 'LAND CRUISER'
  end

  factory :model_corolla, class: Model do
    id_modelo 2
    modelo_descripcion 'COROLLA'
  end

end