# encoding: utf-8

# The idea is re-utilization of this methods in any spec

require 'contexts/shared.rb'

def create_show_prmotions_carousel_context
    create_rvms
    create_brands
    create_models
    create_vehicle_type
    create_vmes
    create_generic_pautas
    create_specific_pautas
    create_categories
    create_promotions
end

def create_specific_show_prmotions_carousel_context
  create_show_prmotions_carousel_context
  create_specific_promotions
end

def create_stubs
end

def create_promotions
  product_category = Category.find_by(name: 'Productos')
  vehicle_category = Category.find_by(name: 'Vehículos')
  service_category = Category.find_by(name: 'Servicios')

  # Should be shown

  # First three elements on carousel
  pp1 = create(:active_promotion, category_id: product_category.id, name: 'product_promotion_shown_1', priority: 6)
  vp1 = create(:active_promotion, category_id: vehicle_category.id, name: 'vehicle_promotion_shown_1', priority: 5)
  sp1 =create(:active_promotion, category_id: service_category.id, name: 'service_promotion_shown_1', priority: 4)

  create(:promotions_vme, vme_id: nil, promotion_id: pp1.id)
  create(:promotions_vme, vme_id: nil, promotion_id: vp1.id)
  create(:promotions_vme, vme_id: nil, promotion_id: sp1.id)

  # Seconds three elements on carousel
  pp2 = create(:active_promotion, category_id: product_category.id, name: 'product_promotion_shown_2', priority: 3)
  vp2 = create(:active_promotion, category_id: vehicle_category.id, name: 'vehicle_promotion_shown_2', priority: 2)
  sp2 = create(:active_promotion, category_id: service_category.id, name: 'service_promotion_shown_2', priority: 1)

  create(:promotions_vme, vme_id: nil, promotion_id: pp2.id)
  create(:promotions_vme, vme_id: nil, promotion_id: vp2.id)
  create(:promotions_vme, vme_id: nil, promotion_id: sp2.id)

  # Shouldn't be shown
  # Don't show by status
  npp1 = create(:promotion, category_id: product_category.id, name: 'product_promotion_dont_shown_1', status: true, from_date: (Date.today - 1.day), to_date: (Date.today + 1.day), max_coupons: 0)
  # Don't show by dates
  nvp1 = create(:promotion, category_id: vehicle_category.id, name: 'vehicle_promotion_dont_shown_1', status: false, from_date: (Date.today - 1.day), to_date: (Date.today + 1.day))
  # Don't show by stock
  nsp1 = create(:promotion, category_id: service_category.id, name: 'service_promotion_dont_shown_1', status: true, from_date: (Date.today - 2.day), to_date: (Date.today - 1.day))

  create(:promotions_vme, vme_id: nil, promotion_id: npp1.id)
  create(:promotions_vme, vme_id: nil, promotion_id: nvp1.id)
  create(:promotions_vme, vme_id: nil, promotion_id: nsp1.id)
end

def create_specific_promotions
  product_category = Category.find_by(name: 'Productos')
  vehicle_category = Category.find_by(name: 'Vehículos')
  service_category = Category.find_by(name: 'Servicios')

  vme = Vme.first # TOYOTA LANDCRUISER

  # Should be shown

  # First three elements on carousel
  pp1 = create(:active_promotion, category_id: product_category.id, name: 'specific_product_promotion_shown_1', priority: 3)
  vp1 = create(:active_promotion, category_id: vehicle_category.id, name: 'specific_vehicle_promotion_shown_1', priority: 2)
  sp1 =create(:active_promotion, category_id: service_category.id, name: 'specific_service_promotion_shown_1', priority: 1)

  create(:promotions_vme, vme_id: vme.vme_id, promotion_id: pp1.id)
  create(:promotions_vme, vme_id: vme.vme_id, promotion_id: vp1.id)
  create(:promotions_vme, vme_id: vme.vme_id, promotion_id: sp1.id)
end

