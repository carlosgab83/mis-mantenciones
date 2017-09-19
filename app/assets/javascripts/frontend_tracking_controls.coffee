
window.FrontendTrackingControls ?= {}

# Event listener:
FrontendTrackingControls.ready = ->
  # Insert initilization code here
  FrontendTrackingControls.initilization()

$(document).ready(FrontendTrackingControls.ready)
$(document).on('page:load', FrontendTrackingControls.ready)

#############################################################################

FrontendTrackingControls.initilization = () ->
  $('.track-click').click ->
    params = {}
    params['data'] = ''

    text = ''
    if (a=$(this).find('a')[0])
      text = a.text

    params['event'] = 'Click on ' + text

    url = '/frontend_tracking'
    method ="POST"
    success_function = ->
    generalControls.sendAjax(params, url, success_function, method)
#############################################################################
