
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
    checkoutsControls.update_price_by_quantity()

  $('#buyable-quantity_selector').focusout ->
    checkoutsControls.update_price_by_quantity()

  $('#order_commune_id.delivery-form').on 'change', ->
    $('#order_region.delivery-form').val regions[@value]

  $('#order_same_contact_info').on 'change', ->
    contact_seller = $('#order_contact_seller.delivery-form')
    contact_phone = $('#order_contact_phone.delivery-form')
    if @checked
      $(contact_seller).val(checkoutsControls.get_full_name()).prop 'readonly', true
      $(contact_phone).val($('#order_phone').val()).prop 'readonly', true
    else
      $(contact_seller).val('').prop 'readonly', false
      $(contact_phone).val('').prop 'readonly', false

  $('#order_name, #order_primary_last_name').on 'change', ->
    if checkoutsControls.contact_info_checked()
      $('#order_contact_seller.delivery-form').val checkoutsControls.get_full_name()

  $('#order_phone').on 'change', ->
    if checkoutsControls.contact_info_checked()
      $('#order_contact_phone.delivery-form').val $('#order_phone').val()

#############################################################################

checkoutsControls.update_price_by_quantity = () ->
  params = {}
  params['quantity'] = document.getElementById('buyable-quantity_selector').value
  params['price'] = $('#buyable-quantity_selector').data('price')
  url = "/checkout/update_price_by_quantity"
  method ="GET"
  success_function = ->
  generalControls.sendAjax(params, url, success_function, method)

#############################################################################

checkoutsControls.get_full_name = () ->
  full_name = $('#order_name').val() + ' ' + $('#order_primary_last_name').val()
  full_name = if full_name == ' ' then '' else full_name
  return full_name

#############################################################################

# Called in onSubmit event
checkoutsControls.process_order = (form_id) ->
  submit_button = $('#' + form_id).find(':submit')[0]
  submit_button.innerText = "PROCESANDO ORDEN..."
  checkoutsControls.fill_retirement_type()
  generalControls.showLoadingEffect()

#############################################################################

checkoutsControls.contact_info_checked = () ->
  return $('#order_same_contact_info')[0].checked

#############################################################################

checkoutsControls.fill_retirement_type = () ->
  tab = $("#section-3 div.active")[0]
  if tab
    $('#order_retirement_type').val(tab.id)
  else
    if $('#order_street_address')[0]
      $('#order_retirement_type').val('delivery-tab')
    else
      $('#order_retirement_type').val('click-n-collect-tab')

#############################################################################
