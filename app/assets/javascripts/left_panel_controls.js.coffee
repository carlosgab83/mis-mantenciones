
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

  $('#uncheck-checkboxes').on 'click', ->
    $('.checkbox input').attr('checked', false)

  $('#floating-form').on 'stepChange', ->
    $('#left-map').addClass('open')

  $('.open-sidebar').on 'click', ->
    $(this).parent().toggleClass('open')
    if ($(this).parent().attr('id') == "left-map")
      $('#floating-form').addClass('next-step')

  $('.close-sidebar').on 'click', ->
    $(this).parent().removeClass('open')