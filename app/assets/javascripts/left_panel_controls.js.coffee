
window.leftPanelControls ?= {}

# Event listener:
leftPanelControls.ready = ->
  # Insert initilization code here
  leftPanelControls.initilization()

$(document).ready(leftPanelControls.ready)
$(document).on('page:load', leftPanelControls.ready)

#############################################################################

leftPanelControls.initilization = () ->
  $('#services-search').on 'click', ->
    $('#floating-form').addClass('next-step').trigger 'stepChange'

  $('#uncheck-checkboxes').change ->
    if $(this).is(':checked')
      leftPanelControls.chackAllFilters(true)
    else
      leftPanelControls.chackAllFilters(false)

  $('#floating-form').on 'stepChange', ->
    if ($('#floating-form').css('margin-top') != '-90px')
      $('#left-map').addClass('open')

  $('.open-sidebar').on 'click', ->
    if ($(this).parent().attr('id') == "left-map")
      $(this).parent().toggleClass('open')
      $('#floating-form').addClass('next-step')
      if ($(this).css('position') == 'fixed')
        $('#right-map').removeClass('open')

    if (($(this).parent().attr('id') == "right-map") && ($('#right-map .panel').html()?))
      $(this).parent().toggleClass('open')
      $('#map').toggleClass('right-open')
      if ($(this).css('position') == 'absolute')
        $('#right-map').removeClass('open')

  $('.close-sidebar').on 'click', ->
    $(this).parent().removeClass('open')
    $('#map').removeClass('right-open')

  $('#search-input-left-panel').on 'focus', ->
    $(this).select()

  $('#search_brand_id').on 'change', ->
    leftPanelControls.getModelsByBrand($(this).val())

#############################################################################

leftPanelControls.getModelsByBrand = (selectedBrandId) ->
  params = {}
  params['brand_id'] = selectedBrandId
  url = '/search-branches/model_collection'
  method ="GET"
  success_function = ->
  generalControls.sendAjax(params, url, success_function, method)

#############################################################################

leftPanelControls.resetBasicForm = () ->
  document.getElementById("basic-search-form").reset()
  brandPiker = $("#search_brand_id")
  $(brandPiker).val('default')
  $(brandPiker).selectpicker("refresh")
  modelPiker = $("#search_model_id")
  $(modelPiker).val('default')
  $(modelPiker).selectpicker("refresh")

#############################################################################

leftPanelControls.resetAdvancedForm = () ->
  document.getElementById("advanced-search-form").reset()

#############################################################################

leftPanelControls.chackAllFilters = (checkOrUncheck) ->
  # checkOrUncheck is a boolean
  for checkbox in $('#filter-list').find('.checkbox input:checkbox')
    do ->
      checkbox.checked = checkOrUncheck

#############################################################################

leftPanelControls.selectBranchTypesFilters = (filtersToSelect) ->
  # Do nothing if no params passed
  if filtersToSelect.length == 0 || (filtersToSelect.length == 1 && filtersToSelect[0] == null)
    return

  leftPanelControls.chackAllFilters(false)
  document.getElementById('uncheck-checkboxes').checked = false # Uncheck SelectAll option

  for optionId in filtersToSelect
    document.getElementById('branch-type-' + optionId).checked = true # Check this option

#############################################################################