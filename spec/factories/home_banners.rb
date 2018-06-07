require "ffaker"

FactoryGirl.define do

  factory :home_banner do
    name { FFaker::NameBR.name}
    title { FFaker::Lorem.paragraph}
    subtitle { FFaker::Lorem.paragraph}
    from_date { FFaker::Time.date }
    to_date { FFaker::Time.date }
    image_url { FFaker::Lorem.paragraph}
    image_click_url { FFaker::Lorem.paragraph}
    button_click_url { FFaker::Lorem.paragraph}
    button_text { FFaker::Lorem.paragraph}
    image_click_new_page true
    button_click_new_page true
    status true
    priority 1
  end

  factory :invalid_home_banner, class: 'HomeBanner' do
  end
end
