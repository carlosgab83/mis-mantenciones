class VehicleFinder < BaseService

  def call
    row = (execute query params.patent).first
    Vehicle.new(row, params.patent, params.kms)
  end

  private

  def query(patent)
    query = ActiveRecordHelper.sanitize_sql(["select v_marca, v_modelo, v_ano_fab, v_cod_marca, v_cod_modelo, v_motor, v_chasis, v_cod_tveh
      from v_rvm_vehiculo where v_rvm= ?", params.patent])
  end
end
