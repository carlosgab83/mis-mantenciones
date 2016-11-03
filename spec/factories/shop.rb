require "ffaker"

FactoryGirl.define do

  factory :shop do
    name { FFaker::NameBR.name }
    rut { FFaker::SSNSE.ssn }
  end

end