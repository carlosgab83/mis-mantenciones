
window.couponsControls ?= {}

# Event listener:
couponsControls.ready = ->

$(document).ready(couponsControls.ready)
$(document).on('page:load', couponsControls.ready)

#############################################################################

couponsControls.buyPromotion = (promotionAnchorElement) ->
  params = {}
  params['partial'] = '/coupons/obtain_coupon_before'
  params['success_partial'] = '/coupons/obtain_coupon_done'
  params['promotion_id'] = $(promotionAnchorElement).data('id')
  url = "/clients/new";
  method ="GET";
  success_function = ->
  generalControls.sendAjax(params, url, success_function, method);

#############################################################################
