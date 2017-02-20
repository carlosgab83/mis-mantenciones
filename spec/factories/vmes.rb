require "ffaker"

FactoryGirl.define do

  factory :vme_land_cruiser, class: 'Vme' do
    vme_id '000001'
    id_modelo 1
    tv_id 1
    vme_mod_especifico 'LAND CRUISER VX'
    vme_estado 1
  end

  factory :vme_corolla, class: 'Vme' do
    vme_id '000002'
    id_modelo 2
    tv_id 1
    vme_mod_especifico 'COROLLA GLX'
    vme_estado 1
  end

end