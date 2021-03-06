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

def create_generic_pautas
  create(:pauta, kilometraje: 10000)
end

def create_specific_pautas
  model_land_cruiser = Model.find_by(modelo_descripcion: 'LAND CRUISER')
  vme = Vme.where(id_modelo: model_land_cruiser.id_modelo).first
  create(:pauta, kilometraje: 10000, vme_id: vme.id, id_modelo: model_land_cruiser.id_modelo)
  create(:pauta, kilometraje: 20000, vme_id: vme.id, id_modelo: model_land_cruiser.id_modelo)
end

def create_categories
  create(:category, name: 'Vehículos')
  create(:category, name: 'Servicios')
  create(:category, name: 'Productos')
  create(:category, name: 'Neumáticos', slug: 'Neumaticos')
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

def create_system_setting_values
  SystemSetting.create(
    default_latitude: 0,
    default_longitude: 0,
    default_zoom: 10,
    product_scraping_caching_minutes: 1
  )
end

def create_branch
  create(:branch)
end

def associate_branch_to_promotion
  branch = Branch.first
  # branch.promotions = []
  Promotion.all.each do |promotion|
    next if promotion.branches.any?
    branch.promotions << promotion
  end
end
