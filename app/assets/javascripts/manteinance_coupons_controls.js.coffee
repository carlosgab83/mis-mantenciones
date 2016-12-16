
window.manteinanceCouponsControls ?= {}

# Event listener:
manteinanceCouponsControls.ready = ->
  manteinanceCouponsControls.alternativesList = {}

$(document).ready(manteinanceCouponsControls.ready)
$(document).on('page:load', manteinanceCouponsControls.ready)

#############################################################################

manteinanceCouponsControls.drawItemsForBranch = (branchAnchorElement) ->
  branchId = $(branchAnchorElement).data('branch_id')
  branchElement = manteinanceCouponsControls.findBranch(branchId)

  branchElementManteinanceItemsIds = $(branchElement['branch_pauta']['branch_manteinance_items']).map( ->
    $(@)[0]['id']
  )
  $('#branches-manteinance-items li').each (index, manteinanceItemListElement) =>
    if branchElementManteinanceItemsIds.index($(manteinanceItemListElement).data('id')) != -1
      $(manteinanceItemListElement).addClass('active')
    else
      $(manteinanceItemListElement).removeClass('active')

#############################################################################

manteinanceCouponsControls.similarPauta = (checkboxFilterElement) ->
  element = $('.modal-selector > label > input[name=double_traction]')
  double_traction = $(element).size() > 0 && $(element)[0].checked

  element = $('.modal-selector > label > input[name=diesel_engine]')
  diesel_engine = $(element).size() > 0 && $(element)[0].checked

  element = $('.modal-selector > label > input[name=automatic_transmission]')
  automatic_transmission = $(element).size() > 0 && $(element)[0].checked

  pautaToRequest = null
  for pauta in manteinanceCouponsControls.alternativesList['similar_pautas']
    if pauta['double_traction'] == double_traction && pauta['diesel_engine'] == diesel_engine && pauta['automatic_transmission'] == automatic_transmission
      pautaToRequest = pauta
      break

  if pautaToRequest == null
    run = () ->
      checkboxFilterElement.checked = !checkboxFilterElement.checked
    setTimeout(run, 400)
    return

  params = {};
  params['manteinance_coupon[id_pauta]'] = pautaToRequest['id']
  params['active_sorting_button'] = $('.modal-header > .sort-buttons >label.active > input')[0].value

  url = "/manteinance_coupons/new";
  method ="GET";
  success_function = ->
  generalControls.sendAjax(params, url, success_function, method);

#############################################################################

manteinanceCouponsControls.sortBranches = (optionalClickedElement = null) ->
  # Sort method can be: 'most_complete' or 'best_price'
  sort_method = $('.modal-header > .sort-buttons > label.active > input')[0].value

  if optionalClickedElement != null
    sort_method = $(optionalClickedElement).find('input')[0].value

  if sort_method == 'most_complete'
    manteinanceCouponsControls.sortByMostComplete()

  if sort_method == 'best_price'
    manteinanceCouponsControls.sortByBestPrice()

  $('.manteinance_coupon-branches li a')[0].click()

  manteinanceCouponsControls.updateBookingButton()

#############################################################################

manteinanceCouponsControls.sortByMostComplete = () ->
  $('.manteinance_coupon-branches li').sort( (a, b) ->
    $(b).data('manteinance-items-count') - $(a).data('manteinance-items-count')
  ).appendTo('.manteinance_coupon-branches')
  manteinanceCouponsControls.alternativesList['branches'] = manteinanceCouponsControls.alternativesList['branches'].sort( (a, b) ->
    b['branch_pauta']['branch_manteinance_items'].size - a['branch_pauta']['branch_manteinance_items'].size
  )

#############################################################################

manteinanceCouponsControls.sortByBestPrice = () ->
  $('.manteinance_coupon-branches li').sort( (a, b) ->
    $(a).find('.special').data('price') - $(b).find('.special').data('price')
  ).appendTo('.manteinance_coupon-branches')
  manteinanceCouponsControls.alternativesList['branches'] = manteinanceCouponsControls.alternativesList['branches'].sort( (a, b) ->
    a['promo_price'] - b['promo_price']
  )

#############################################################################

manteinanceCouponsControls.obtainManteinanceCoupon = () ->
  params = {}
  params['partial'] = '/manteinance_coupons/obtain_manteinance_coupon_before'
  params['success_partial'] = '/manteinance_coupons/obtain_manteinance_coupon_client_registered'
  params['branch_id'] = manteinanceCouponsControls.activeBranch().data('branch_id')
  params['id_pauta'] = manteinanceCouponsControls.alternativesList['pauta']['id']
  url = "/clients/new";
  method ="GET";
  success_function = ->
  generalControls.sendAjax(params, url, success_function, method);

#############################################################################

manteinanceCouponsControls.bookManteinanceCoupon = (clientInformation = null) ->
  params = {}
  params['partial'] = '/manteinance_coupons/book_manteinance_coupon_before'
  params['success_partial'] = '/manteinance_coupons/book_manteinance_coupon_client_registered'
  params['branch_id'] = manteinanceCouponsControls.activeBranch().data('branch_id')
  params['id_pauta'] = manteinanceCouponsControls.alternativesList['pauta']['id']
  url = "/clients/new";
  method ="GET";
  success_function = ->
  generalControls.sendAjax(params, url, success_function, method);

#############################################################################

manteinanceCouponsControls.findBranch = (branchId) ->
  for branch in manteinanceCouponsControls.alternativesList['branches']
    if branchId == branch['id']
      return branch

#############################################################################

manteinanceCouponsControls.activeBranch = () ->
  $('.manteinance_coupon-branches > li.active > a')

#############################################################################

manteinanceCouponsControls.updateBookingButton = () ->
  if manteinanceCouponsControls.activeBranch().data('booking-url') != ''
    $('#book-manteinance-copupon').show()
  else
    $('#book-manteinance-copupon').hide()

#############################################################################

manteinanceCouponsControls.updateObtainManteinanceCouponButton = () ->
  if manteinanceCouponsControls.activeBranch().data('booking-url') != ''
    $('#obtain-manteinance-coupon').hide()
  else
    $('#obtain-manteinance-coupon').show()

#############################################################################