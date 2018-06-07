class HomeBanner < ApplicationRecord
  validates :name, :title, :subtitle, :image_url, :image_click_url, :button_text,
    :button_click_url, :from_date, :to_date, :priority, presence: true

  scope :availables, -> {where("? between from_date and to_date", Date.today)}
  scope :actives, -> {where("status is true")}
  scope :not_deleted, -> {where(deleted: [false, nil])}
end
