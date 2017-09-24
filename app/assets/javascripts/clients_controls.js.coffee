
window.clientsControls ?= {}

# Event listener:
clientsControls.ready = ->
  # Insert initilization code here

#############################################################################

clientsControls.registerClient = (returningFunction) ->
  clientInformation = {}
  $('#contact-modal').modal('show')
  returningFunction(clientInformation)