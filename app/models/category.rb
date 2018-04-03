class Category < ApplicationRecord
  acts_as_nested_set

  include CategorySerializer
  extend  FriendlyId

  rails_admin do
    nested_set({
        max_depth: 15,
        toggle_fields: [:enabled],
        thumbnail_fields: [:image, :cover],
        thumbnail_size: :thumb,
        thumbnail_gem: :paperclip#, # or :carrierwave
        #scopes: [:deleted, :disabled] # filter nodes by scope
    })
  end

  has_many :products
  has_many :promotions

  scope :not_blog, -> {where("categories.name <> 'Blog'")}

  # Use friendly id based on name
  friendly_id :name, use: :slugged
end
