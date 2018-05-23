class HomeBanner < ApplicationRecord
  validates :name, :title, :subtitle, :image_url, :image_click_url, :button_text,
    :button_click_url, :image_click_new_page, :button_click_new_page,
    :from_date, :to_date, :priority, :status, presence: true
end
