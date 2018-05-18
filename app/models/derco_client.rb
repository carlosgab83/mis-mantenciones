class DercoClient
  include ActiveModel::Model

  attr_accessor :name, :email, :phone, :comune_id, :manteinance_type, :brand, :message
end
