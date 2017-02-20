# encoding: utf-8

# The idea is re-utilization of this methods in any spec

def create_rvms
  create(:rvm_land_cruiser)
  create(:rvm_corolla)
end

def create_brands
  create(:brand_toyota)
end

def create_models
  toyota_brand = Brand.find_by(descripcion: 'TOYOTA')
  create(:model_land_cruiser, id_marca: toyota_brand.id_marca)
  create(:model_corolla, id_marca: toyota_brand.id_marca)
end

def create_vehicle_type
  create(:vehicle_type)
end

def create_vmes
  vehicle_type = VehicleType.first
  create(:vme_land_cruiser, tv_id: vehicle_type.tv_id)
  create(:vme_corolla, tv_id: vehicle_type.tv_id)
end

