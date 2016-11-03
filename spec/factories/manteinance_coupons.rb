require "ffaker"

FactoryGirl.define do

  factory :manteinance_coupon do
    price { Random.new.rand(1000).to_f }
    date { FFaker::Time.date }
    pauta_id 1
    branch
    client
  end

  factory :invalid_manteinance_coupon, class: 'ManteinanceCoupon' do
  end

end