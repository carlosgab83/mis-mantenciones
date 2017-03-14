require "ffaker"

FactoryGirl.define do

  factory :category do
    name { FFaker::NameBR.name }
  end

end