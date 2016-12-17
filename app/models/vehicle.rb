# encoding: utf-8
class Vehicle

  attr_reader :rvm_brand, :rvm_model, :manufacturing_year, :brand_id, :model_id, :engine_serial, :chassis_serial, :patent, :kms, :found
  attr_accessor :vme

  # Input is onw row of db view v_rvm_vehiculo
  def initialize(v_rvm_vehiculo, patent, kms)
    self.found = false
    if v_rvm_vehiculo.present?
      v_rvm_vehiculo.symbolize_keys!
      self.rvm_brand = v_rvm_vehiculo[:v_marca]
      self.rvm_model = v_rvm_vehiculo[:v_modelo]
      self.manufacturing_year = v_rvm_vehiculo[:v_ano_fab]
      self.brand_id = v_rvm_vehiculo[:v_cod_marca]
      self.model_id = v_rvm_vehiculo[:v_cod_modelo]
      self.engine_serial = v_rvm_vehiculo[:v_motor]
      self.chassis_serial = v_rvm_vehiculo[:v_chassis]
      self.found = true
    end

    self.patent = adjust(patent)
    self.kms = kms.to_i
  end

  def brand_name
    if brand_id.present?
      Brand.find(brand_id).descripcion.try(:upcase)
    else
      "Vehículo"
    end
  end

  def model_name
    rvm_model.try(:upcase)
    # if model_id.present?
    #   Model.find(model_id).modelo_descripcion.try(:downcase).try(:camelize)
    # else
    #   ""
    # end
  end

  attr_writer :rvm_brand, :rvm_model, :manufacturing_year, :brand_id, :model_id, :engine_serial, :chassis_serial, :patent, :kms, :found

  private

  # For Motorcycles, if patent has 5 characters, one '0' must be inserted after last letter
  # It assumes that patent has 5 or 6 characters. Not other option
  def adjust(patent)
    return patent unless patent.length < 6
    i = first_number_index(patent)
    "#{patent[0..(i-1)]}0#{patent[i..-1]}"
  end

  def first_number_index(patent)
    patent.index(/[0123456789]/)
  end
end
