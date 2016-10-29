require "ffaker"

FactoryGirl.define do

  factory :promotion do
    name { FFaker::NameBR.name}
    description { FFaker::Lorem.paragraph}
    from_date { FFaker::Time.date }
    to_date { FFaker::Time.date }
    full_price { Random.new.rand(1000).to_f }
    promo_price { Random.new.rand(1000).to_f }
    discount_percentage { Random.new.rand(0.5).to_f }
    status true
    max_coupons 100
    priority 1
  end

  factory :invalid_promotion, class: 'Coupon' do
  end

end