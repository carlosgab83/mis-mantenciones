
window.leftPanelControls ?= {}

# Event listener:
leftPanelControls.ready = ->
  # Insert initilization code here
  leftPanelControls.initilization()

#############################################################################

leftPanelControls.initilization = () ->
  $('#uncheck-checkboxes').change ->
    if $(this).is(':checked')
      leftPanelControls.chackAllFilters(true)
    else
      leftPanelControls.chackAllFilters(false)

  $('#floating-form').on 'stepChange', ->
    if ($('#floating-form').css('margin-top') != '-112px')
      $('#left-map').addClass('open')

  $('.open-sidebar').on 'click', ->
    if ($(this).parent().attr('id') == "left-map")
      $(this).parent().toggleClass('open')
      $('#floating-form').addClass('next-step')
      if ($('.navbar-toggle').css('display') != 'none')
        $('#right-map').removeClass('open')

    # This is the code thar opens and closes the right panel
    if (($(this).parent().attr('id') == "right-map") && ($('#right-map .panel').html()?))
      $(this).parent().toggleClass('open')
      $('#map').toggleClass('right-open')
      if ($('.navbar-toggle').css('display') != 'none')
        $('#left-map').removeClass('open')

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
  generalControls.refreshSelectPicker($("#search_brand_id"))
  generalControls.refreshSelectPicker($("#search_model_id"))

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
  if filtersToSelect == null || filtersToSelect.length == 0 || (filtersToSelect.length == 1 && (filtersToSelect[0] == null || filtersToSelect[0] == false))
    return

  if (filtersToSelect.length >= 1 && filtersToSelect[0] == 0) # User selects all services
    leftPanelControls.chackAllFilters(true)
    document.getElementById('uncheck-checkboxes').checked = true # check SelectAll option
    return

  leftPanelControls.chackAllFilters(false)
  document.getElementById('uncheck-checkboxes').checked = false # Uncheck SelectAll option

  for optionId in filtersToSelect
    document.getElementById('branch-type-' + optionId).checked = true # Check this option

#############################################################################

leftPanelControls.storeNewUserSelection = () ->
  branch_type_ids = $('#branch_types-filters input:checked').map(-> return (parseInt(this.value) || 0)).get()
  possible_null_index = branch_type_ids.indexOf(0)
  if possible_null_index >= 0
    branch_type_ids = [null] # Represents select_all elements
  sessionStorage.setItem('left_panel_branch_type_ids', JSON.stringify(branch_type_ids))

#############################################################################