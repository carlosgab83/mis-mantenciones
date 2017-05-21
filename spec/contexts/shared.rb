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

def create_categories
  create(:category, name: 'Vehículos')
  create(:category, name: 'Servicios')
  create(:category, name: 'Productos')
end

def create_search_patent_stub_proc
  -> (return_data) {
    allow_any_instance_of(VehicleFinder).to receive(:execute).and_return(return_data)
  }
end

def toyota_land_cruiser_finder_attributes
  rvm = Rvm.first
  vme = Vme.first
  [rvm.attributes.merge(vme.attributes).merge(v_cod_marca: vme.model.id_marca, v_cod_modelo: vme.id_modelo)]
end
