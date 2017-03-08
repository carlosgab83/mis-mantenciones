require "ffaker"

FactoryGirl.define do

  factory :brand_toyota, class: Brand do
    id_marca 1
    descripcion 'TOYOTA'
  end

end