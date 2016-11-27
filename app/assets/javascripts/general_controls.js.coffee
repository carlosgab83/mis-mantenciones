
window.generalControls ?= {}

generalControls.ready = ->
  generalControls.hideLoadingEffect()
  $(document).ajaxStart ->
    generalControls.showLoadingEffect()
  $(document).ajaxSuccess ->
    generalControls.hideLoadingEffect()
  $(document).ajaxError ->
    generalControls.hideLoadingEffect()


$(document).ready(generalControls.ready)
$(document).on('pasge:load', generalControls.ready)

############################################################################

generalControls.sendAjax = (params, url, success_function, method) ->
  $.ajax url,
    type: method || 'POST'
    dataType: 'script',
    data: params,
    error: (jqXHR, textStatus, errorThrown) ->
      generalControls.hideLoadingEffect()
    success: (data, textStatus, jqXHR) ->
      success_function()

#############################################################################

generalControls.showLoadingEffect = () ->
  $('.loader').show();
  $('body').addClass('loading-time');

#############################################################################

generalControls.hideLoadingEffect = () ->
  $('.loader').hide();
  $('body').removeClass('loading-time');