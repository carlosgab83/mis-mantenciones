require "ffaker"

FactoryGirl.define do

  factory :branch do
    name { FFaker::NameBR.name }
    shop
    will_contact false
  end

end