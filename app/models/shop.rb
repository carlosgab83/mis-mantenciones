class Shop < ApplicationRecord

  extend FriendlyId

  # Use friendly id based on name
  friendly_id :name, use: :slugged
  has_many :branches

  validates :click_n_collect_enabled, :delivery_enabled, inclusion: { in: [true, false] }, presence: true
  validates :installation_enabled, presence: true

  INSTALLATION_DISABLED = 0
  INSTALLATION_ENABLED_ONLY_BRANCH = 1
  INSTALLATION_ENABLED_ONLY_DELIVERY = 2
  INSTALLATION_ENABLED = 3

  # Read automatically by rails_admin
  %w(click_n_collect_enabled delivery_enabled).each do |method_name|
    define_method :"#{method_name}_enum" do
        [['Si', true], ['No', false]]
    end
  end

  # Read automatically by rails_admin
  def installation_enabled_enum
    [
      ['No disponible', INSTALLATION_DISABLED],
      ['Solo en local', INSTALLATION_ENABLED_ONLY_BRANCH],
      ['Solo a domicilio', INSTALLATION_ENABLED_ONLY_DELIVERY],
      ['Disponible', INSTALLATION_ENABLED]
    ]
  end

  def branch_installation?
    installation_enabled == INSTALLATION_ENABLED_ONLY_BRANCH or installation_enabled == INSTALLATION_ENABLED
  end

  def delivery_installation?
    installation_enabled == INSTALLATION_ENABLED_ONLY_DELIVERY or installation_enabled == INSTALLATION_ENABLED
  end
end
