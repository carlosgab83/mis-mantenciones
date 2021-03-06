
window.searchProductsControls ?= {}

# Event listener:
searchProductsControls.ready = ->
  $(searchProductsControls.activeForm()).find('button:submit').click ->
    generalControls.showLoadingEffect()

  if $(window).width() > 768
    $('#_price-filters').collapse("show")

  if !generalControls.isMobileScreen()
    $('a.vertical-filter').first().removeClass('collapsed')
    $('.panel-collapse.vertical-filter').first().addClass('in')

  $('#search-products-clean-filters').click ->
    for select_element in $(searchProductsControls.activeForm()).find('select')
      do ->
        generalControls.refreshSelectPicker(select_element)
    searchProductsControls.submitForm()

#############################################################################

searchProductsControls.dynamicSelectors = ->
  $('#client_search_input_horizontal_filters_by_vehicle_brand_id').change ->
    params = {}
    params['brand_id'] = $(this).val()
    url = '/search_products/model_collection'
    method ="GET"
    success_function = ->
    generalControls.sendAjax(params, url, success_function, method)

$(document).ready(searchProductsControls.dynamicSelectors)
$(document).on('page:load', searchProductsControls.dynamicSelectors)

#############################################################################

searchProductsControls.dynamicHorizontalFilters = ->
  $('select.dynamic-horizontal-filters').change ->
    searchProductsControls.submitForm()

$(document).ready(searchProductsControls.dynamicHorizontalFilters)
$(document).on('page:load', searchProductsControls.dynamicHorizontalFilters)

#############################################################################

searchProductsControls.activeForm = ->
  return $('.search-criteria.active form')[0]

#############################################################################

searchProductsControls.submitForm = ->
  $(searchProductsControls.activeForm()).find('button[type="submit"]').click()

#############################################################################

# Appends all vertical filters to active form and do submit
searchProductsControls.clickOnVerticalFilters = ->
  $('#parts-filters ul li').change ->
    if $(this).data('value') == '_select_all' && $(this).find('input[type=checkbox]')[0].checked == true
      for checkbox in $(this).closest('ul').find('li input:checkbox:checked')
        do ->
          checkbox.checked = false
    else if $(this).data('value') == '_select_all' && $(this).find('input[type=checkbox]')[0].checked == false
      # Don't do anything
      return
    else if $(this).data('value') != '_select_all' && !this.classList.contains('price-range')
      $(this).closest('ul').find('li[data-value="_select_all"]').find('input[type=checkbox]')[0].checked = false
    searchProductsControls.insertVerticalFiltersOnActiveform()
    searchProductsControls.submitForm()

$(document).ready(searchProductsControls.clickOnVerticalFilters)
$(document).on('page:load', searchProductsControls.clickOnVerticalFilters)

#############################################################################

searchProductsControls.insertVerticalFiltersOnActiveform = ->
  form = searchProductsControls.activeForm()
  searchProductsControls.deleteVerticalFiltersFromForm(form)
  $('#parts-filters ul li input:checkbox:checked').each (index, checkbox) ->
    attribute_id = $(checkbox).parents('ul:first').data('attribute_id')
    input_name  = "client_search_input[vertical_filters[attributes["+attribute_id+"]]][]"
    input_value = $(checkbox).parents('li:first').data('value')
    $(form).append("<input type='hidden' class='vertical-filters' name='"+input_name+"' value='"+input_value+"'/>")

  $('#parts-filters ul li input:text').each (index, text_field) ->
    attribute_id = $(text_field).parents('ul:first').data('attribute_id')
    input_name  = "client_search_input[vertical_filters[attributes["+attribute_id+"]]][]"
    input_value = text_field.value.replace(/\./g,'').replace(/\,/g,'')
    $(form).append("<input type='hidden' class='vertical-filters' name='"+input_name+"' value='"+input_value+"'/>")

#############################################################################

searchProductsControls.deleteVerticalFiltersFromForm = (form) ->
  $(form).find('input:hidden.vertical-filters').each (index, input_element) ->
    input_element.remove()

#############################################################################

# Appends all vertical filters to active form and do submit
searchProductsControls.clickOnPaginationLinks = ->
  $('div.pagination a').click ->
    form = searchProductsControls.activeForm()
    page = $(this).parents('div:first').data('page')
    $(form).append("<input type='hidden' name='client_search_input[page]' value='"+page+"'/>")
    searchProductsControls.insertVerticalFiltersOnActiveform()
    searchProductsControls.submitForm()

$(document).ready(searchProductsControls.clickOnPaginationLinks)
$(document).on('page:load', searchProductsControls.clickOnPaginationLinks)

#############################################################################

searchProductsControls.goTosearchFromOtherPage = ->
  $('.go-to-search-neumaticos').click ->
    generalControls.showLoadingEffect()
    form = searchProductsControls.activeForm()
    $(form).removeAttr("data-remote");
    $(form).removeData("remote");
    $(form).attr("action", $(form).data('go-to'))

$(document).ready(searchProductsControls.goTosearchFromOtherPage)
$(document).on('page:load', searchProductsControls.goTosearchFromOtherPage)

#############################################################################