require "ffaker"

FactoryGirl.define do

  factory :promotion, class: 'OtherPromotion' do
    name { FFaker::NameBR.name}
    description { FFaker::Lorem.paragraph}
    from_date { FFaker::Time.date }
    to_date { FFaker::Time.date }
    full_price { Random.new.rand(1000).to_f }
    promo_price { Random.new.rand(1000).to_f }
    discount_percentage { Random.new.rand(0.5).to_f }
    image_url { FFaker::NameBR.name}
    status true
    max_coupons 100
    priority 1
    category
    button_type 1
  end

  factory :invalid_promotion, class: 'Coupon' do
  end

  factory :active_promotion, class: 'OtherPromotion' do
    name { FFaker::NameBR.name}
    description { FFaker::Lorem.paragraph}
    from_date { Date.today - 1.day }
    to_date { Date.today + 1.day }
    full_price { Random.new.rand(1000).to_f }
    promo_price { Random.new.rand(1000).to_f }
    discount_percentage { Random.new.rand(0.5).to_f }
    image_url { FFaker::NameBR.name}
    status true
    max_coupons 100
    priority 1
    category
    button_type 1
  end

end