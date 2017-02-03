
window.searchProductsControls ?= {}

# Event listener:
searchProductsControls.ready = ->

$(document).ready(searchProductsControls.ready)
$(document).on('page:load', searchProductsControls.ready)

#############################################################################

searchProductsControls.dynamicSelectors = ->
  $('#client_search_input_horizontal_filters_by_vehicle_brand_id').change ->
    params = {}
    params['brand_id'] = $(this).val()
    url = '/search_products/model_collection'
    method ="GET";
    success_function = ->
    generalControls.sendAjax(params, url, success_function, method);

$(document).ready(searchProductsControls.dynamicSelectors)
$(document).on('page:load', searchProductsControls.dynamicSelectors)

#############################################################################

# Appends all vertical filters to active form and do submit
searchProductsControls.clickOnVerticalFilters = ->
  $('#parts-filters ul li').change ->
    generalControls.showLoadingEffect()
    searchProductsControls.insertVerticalFiltersOnActiveform()
    form = $('.search-criteria.active form')[0]
    $(form).find('button:submit').click()

$(document).ready(searchProductsControls.clickOnVerticalFilters)
$(document).on('page:load', searchProductsControls.clickOnVerticalFilters)

#############################################################################

searchProductsControls.insertVerticalFiltersOnActiveform = ->
  form = $('.search-criteria.active form')[0]
  searchProductsControls.deleteVerticalFiltersFromForm(form)
  $('#parts-filters ul li input:checkbox:checked').each (index, checkbox) =>
    attribute_id = $(checkbox).parents('ul:first').data('attribute_id')
    input_name  = "client_search_input[vertical_filters[attributes["+attribute_id+"]]][]"
    input_value = $(checkbox).parents('li:first').data('value')
    $(form).append("<input type='hidden' class='vertical-filters' name='"+input_name+"' value='"+input_value+"'/>")

#############################################################################

searchProductsControls.deleteVerticalFiltersFromForm = (form) ->
  $(form).find('input:hidden.vertical-filters').each (index, input_element) =>
    input_element.remove()

#############################################################################
