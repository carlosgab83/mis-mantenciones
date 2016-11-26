
window.clientsControls ?= {}

# Event listener:
clientsControls.ready = ->
  # Insert initilization code here

$(document).ready(clientsControls.ready)
$(document).on('page:load', clientsControls.ready)

#############################################################################

clientsControls.registerClient = (returningFunction) ->
  clientInformation = {}
  $('#contact-modal').modal('show')
  returningFunction(clientInformation)