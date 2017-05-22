
window.rightPanelControls ?= {}

# Event listener:
rightPanelControls.ready = ->
  # Insert initilization code here


$(document).ready(rightPanelControls.ready)
$(document).on('page:load', rightPanelControls.ready)

#############################################################################
