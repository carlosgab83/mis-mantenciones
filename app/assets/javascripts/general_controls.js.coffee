
window.generalControls ?= {}

# generalControls.ready = ->
#   generalControls.some action here!

# $(document).ready(generalControls.ready)
# $(document).on('pasge:load', generalControls.ready)

############################################################################

generalControls.sendAjax = (params, url, success_function, method) ->
  $.ajax url,
    type: method || 'POST'
    dataType: 'script',
    data: params,
    error: (jqXHR, textStatus, errorThrown) ->
      $('#chart').append "AJAX Error: #{textStatus}"
    success: (data, textStatus, jqXHR) ->
      success_function()

#############################################################################