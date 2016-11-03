require "ffaker"

FactoryGirl.define do

  factory :coupon do
    date { FFaker::Time.date }
    price { Random.new.rand(1000).to_f }
    promotion
    client
  end

  factory :invalid_coupon, class: 'Coupon' do
  end

end