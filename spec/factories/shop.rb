require "ffaker"

FactoryGirl.define do

  factory :shop do
    name { FFaker::NameBR.name }
    rut { FFaker::SSNSE.ssn }
    installation_enabled { true }
    click_n_collect_enabled { true }
    delivery_enabled { true }

  end

  factory :invalid_shop, class: 'Shop' do
  end

end