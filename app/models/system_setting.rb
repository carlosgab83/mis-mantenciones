class SystemSetting < ApplicationRecord

  def self.config
    first
  end
end