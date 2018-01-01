
window.checkoutsControls ?= {}

# Event listener:
checkoutsControls.ready = ->
  # Insert initilization code here
    checkoutsControls.initilization()

#############################################################################

checkoutsControls.initilization = () ->

  $('a.submitable').click ->
    branch_id = $(this).data('branch_id')
    $('#product-to-checkout-branch-id-' + branch_id).submit()

  $('#buyable-quantity_selector').click ->
    params = {}
    params['quantity'] = document.getElementById('buyable-quantity_selector').value
    params['price'] = $('#buyable-quantity_selector').data('price')
    url = "/checkout/update_price_by_quantity"
    method ="GET"
    success_function = ->
    generalControls.sendAjax(params, url, success_function, method)