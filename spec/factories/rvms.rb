require "ffaker"

FactoryGirl.define do

  factory :rvm_land_cruiser, class: 'Rvm' do
    v_rvm 'AAA000'
    v_tipo 'AUTOMOVIL'
    v_marca 'TOYOTA'
    v_modelo 'LANDCRUISER'
    v_color 'GRIS'
    v_motor 'engine_serial_landcruiser'
    v_chasis 'chasis_seial_landcruiser'
    v_ano_fab 2015
    v_pro_rut 12345678
    v_pro_dv '9'
    v_pro_nombre 'Landcruiser Owner Name'
  end

  factory :rvm_corolla, class: 'Rvm' do
    v_rvm 'AAA001'
    v_tipo 'AUTOMOVIL'
    v_marca 'TOYOTA'
    v_modelo 'COROLLA'
    v_color 'NEGRO'
    v_motor 'engine_serial_corolla'
    v_chasis 'chasis_seial_corolla'
    v_ano_fab 2016
    v_pro_rut 12345678
    v_pro_dv '0'
    v_pro_nombre 'Corolla Owner Name'
  end

end