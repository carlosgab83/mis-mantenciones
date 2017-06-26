
window.rightPanelControls ?= {}

# Event listener:
rightPanelControls.ready = ->
  # Insert initilization code here
  rightPanelControls.initilization()

$(document).ready(rightPanelControls.ready)
$(document).on('page:load', rightPanelControls.ready)

#############################################################################

rightPanelControls.initilization = () ->
  # Sidebar open and close logic is on left_panel_controls

#############################################################################
