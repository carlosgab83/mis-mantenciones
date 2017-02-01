
window.searchProductsControls ?= {}

# Event listener:
searchProductsControls.ready = ->

$(document).ready(searchProductsControls.ready)
$(document).on('page:load', searchProductsControls.ready)

#############################################################################

searchProductsControls.dynamic_selectors = ->
  $('#client_search_input_horizontal_filters_brand_id').change ->
    params = {}
    params['brand_id']  = $(this).val()
    url = '/search_products/model_collection'
    method ="GET";
    success_function = ->
    generalControls.sendAjax(params, url, success_function, method);

$(document).ready(searchProductsControls.dynamic_selectors)
$(document).on('page:load', searchProductsControls.dynamic_selectors)

#############################################################################
