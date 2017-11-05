
window.FrontendTrackingControls ?= {}

# Event listener:
FrontendTrackingControls.ready = ->
  # Insert initilization code here
  FrontendTrackingControls.initilization()

$(document).ready(FrontendTrackingControls.ready)
$(document).on('page:load', FrontendTrackingControls.ready)

#############################################################################

FrontendTrackingControls.initilization = () ->

  # If the element clicked if an anchor, then use that, else, find first anchor inside the element clicked
  $('.track-click').click ->
    params = {}

    text = ''

    if this.nodeName == 'A'
      a = this
    else
      a = $(this).find('a')[0]

    if(a)
      text = a.text

    params['data'] = {}
    Object.keys($(a).data()).forEach (key, index) ->
      params['data'][key] = $(a).data(key)

    params['event'] = 'Click on ' + text

    url = '/frontend_tracking'
    method ="POST"
    success_function = ->
    generalControls.sendAjax(params, url, success_function, method)

#############################################################################
