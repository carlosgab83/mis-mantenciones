require "ffaker"

FactoryGirl.define do

  factory :client do
    name { FFaker::NameBR.name}
    primary_last_name { FFaker::NameBR.name}
    email { FFaker::Internet.email }
    comune
  end

  factory :invalid_client, class: 'Client' do
  end

end