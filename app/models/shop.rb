class Shop < ApplicationRecord

  extend FriendlyId

  # Use friendly id based on name
  friendly_id :name, use: :slugged
  has_many :branches

  validates :installation_enabled, :click_n_collect_enabled, :delivery_enabled, inclusion: { in: [true, false] }

  # Read automatically by rails_admin
  %w(installation_enabled click_n_collect_enabled delivery_enabled).each do |method_name|
    define_method :"#{method_name}_enum" do
        [['Si', true], ['No', false]]
    end
  end
end
