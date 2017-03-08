require "ffaker"

FactoryGirl.define do

  factory :promotions_vme do
    promotion
    vme
  end

  factory :invalid_promotions_vme, class: 'PromotionsVme' do
  end

end