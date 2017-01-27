
window.generalControls ?= {}

generalControls.ready = ->
  generalControls.defaultValidations()
  generalControls.hideLoadingEffect()
  $(document).ajaxStart ->
    generalControls.showLoadingEffect()
  $(document).ajaxSuccess ->
    generalControls.hideLoadingEffect()
  $(document).ajaxComplete ->
    generalControls.hideLoadingEffect()

$(document).ready(generalControls.ready)
$(document).on('page:load', generalControls.ready)

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

#############################################################################

generalControls.defaultValidations = () ->
  $(".numeric").lazzynumeric({aSep: ".", aDec: ",", vMin: "0", vMax: "999999"})
  # $(".search-patent").validate({
  #   debug: true,
  #   onsubmit: true,
  #   errorPlacement: (error, element) ->,
  #   errorClass: 'notExistentClass',
  #   rules: {
  #     "search[patent]": {required: true, minlength: 5, maxlength: 6}
  #   },
  #   submitHandler: (form) ->
  #     form.submit()
  # });
