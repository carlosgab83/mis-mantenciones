class ActiveRecordHelper < ApplicationRecord
  self.table_name = "vehiculo_modelo_especifico"

  def self.sanitize_sql *struct
    super *struct
  end
end
