require "ffaker"

FactoryGirl.define do

  factory :comune do
    id_comuna { Random.new.rand(1000) * -1 }
    desc_comuna { FFaker::NameBR.name }
    estado_comuna 1
  end

end