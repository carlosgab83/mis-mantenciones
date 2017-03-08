# encoding: utf-8

# The idea is re-utilization of this methods in any spec

require 'contexts/shared.rb'

def create_search_patent_context
    create_rvms
    create_brands
    create_models
    create_vehicle_type
    create_vmes
    create_generic_pautas
    create_specific_pautas
end

def create_stubs
end