
window.checkoutsControls ?= {}

# Event listener:
checkoutsControls.ready = ->
  # Insert initilization code here
    checkoutsControls.initilization()

#############################################################################

checkoutsControls.initilization = () ->

  $('a.submitable-product').click ->
    branch_id = $(this).data('branch_id')
    $('#product-to-checkout-branch-id-' + branch_id).submit()

  $('a.submitable-promotion').click ->
    $('#product-to-checkout').submit()

  $('#buyable-quantity_selector').click ->
    params = {}
    params['quantity'] = document.getElementById('buyable-quantity_selector').value
    params['price'] = $('#buyable-quantity_selector').data('price')
    url = "/checkout/update_price_by_quantity"
    method ="GET"
    success_function = ->
    generalControls.sendAjax(params, url, success_function, method)

  $('.click-submitable-to-checkout').click ->
    product_id = $(this).data('product_id')
    $('#product-to-checkout-id-' + product_id).submit()

#############################################################################

checkoutsControls.process_order = (form_id) ->
    submit_button = $('#' + form_id).find(':submit')[0]
    submit_button.innerText = "PROCESANDO ORDEN..."
    generalControls.showLoadingEffect()
