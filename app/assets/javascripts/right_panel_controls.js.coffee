
window.rightPanelControls ?= {}

# Event listener:
rightPanelControls.ready = ->
  # Insert initilization code here
  rightPanelControls.initilization()

$(document).ready(rightPanelControls.ready)
$(document).on('page:load', rightPanelControls.ready)

#############################################################################

rightPanelControls.initilization = () ->
  $('#services-search').on 'click', ->
    $('#floating-form').addClass('next-step').trigger 'stepChange'

  $('#uncheck-checkboxes').on 'click', ->
    $('#branch_types-filters input').attr('checked', false)
    $('#branch_types-filters input').each () ->
      branchesControls.filterBranches(this)

  $('#floating-form').on 'stepChange', ->
    $('#left-map').addClass('open')

  $('.open-sidebar').on 'click', ->
    $(this).parent().toggleClass('open')
    if ($(this).parent().attr('id') == "left-map")
      $('#floating-form').addClass('next-step')

  $('.close-sidebar').on 'click', ->
    $(this).parent().removeClass('open')

  $('#search-input-left-panel').on 'focus', ->
    $(this).select()

  $('#search_brand_id').on 'change', ->
    rightPanelControls.getModelsByBrand($(this).val())

#############################################################################

rightPanelControls.getModelsByBrand = (selectedBrandId) ->
  params = {}
  params['brand_id'] = selectedBrandId
  url = '/search-branches/model_collection'
  method ="GET"
  success_function = ->
  generalControls.sendAjax(params, url, success_function, method)

#############################################################################