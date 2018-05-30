
window.indexControls ?= {}

# Event listener:
indexControls.ready = ->
  # Insert initilization code here
  if typeof google != 'undefined' && document.getElementById('search-input-locations')
    indexControls.initAutocomplete()
    indexControls.buttonListeners()

#############################################################################

indexControls.initAutocomplete = () ->
  indexControls.presetInputAddress()

  options = {
    componentRestrictions: {country: "cl"}
  }

  input = document.getElementById('search-input-locations')
  indexControls.autocomplete = new google.maps.places.Autocomplete(input, options)

#############################################################################

indexControls.buttonListeners = () ->
  input = document.getElementById('search-input-locations')

  # Hacky solution for select first PAc if user press enter
  indexControls.selectFirstOnEnter(input)

  # Prevent double event if user press enter
  google.maps.event.addDomListener input, 'keydown', (e) ->
    if e.keyCode == 13
      e.preventDefault()
      e.stopPropagation()

  $('#services-search.map-search').click ->
    indexControls.userSearchAction(indexControls.autocomplete, 'basic-search-form')

  $('#search-input-locations').on 'focus', ->
    $(this).select()

#############################################################################

indexControls.userSearchAction = (autocomplete, formToSubmit) ->
  if autocomplete.getPlace()
    $('#basic-search-form_location_text').val(autocomplete.getPlace().formatted_address)
    $('#basic-search-form_latitude').val(autocomplete.getPlace().geometry.location.lat())
    $('#basic-search-form_longitude').val(autocomplete.getPlace().geometry.location.lng())

  InputServiceSelection = document.getElementById('search_branch_type_id')
  sessionStorage.setItem('left_panel_branch_type_ids', JSON.stringify([parseInt(InputServiceSelection.value)]))
  $('#'+formToSubmit).submit()

#############################################################################

indexControls.presetInputAddress = () ->
  navigator.geolocation.getCurrentPosition(indexControls.successObtainPosition, indexControls.errorObtainPosition)

#############################################################################

indexControls.successObtainPosition = (location) ->
  latitude = location.coords.latitude
  longitude = location.coords.longitude
  indexControls.presetLatlng = new google.maps.LatLng(latitude, longitude)
  geocoder = new google.maps.Geocoder
  geocoder.geocode { 'location': indexControls.presetLatlng }, (results, status) ->
    if status == 'OK'
      element = document.getElementById('search-input-locations')
      element.value = results[0].formatted_address
      element.select()
      $('#basic-search-form_location_text').val(element.value)
      $('#basic-search-form_latitude').val(latitude)
      $('#basic-search-form_longitude').val(longitude)

#############################################################################

indexControls.errorObtainPosition = (error) ->
  alert('No pudimos obtener tu ubicación. Recuerda que debes activar la geolocalización en tu dispositivo')

#############################################################################

indexControls.selectFirstOnEnter = (input) ->
  # store the original event binding function
  _addEventListener = if input.addEventListener then input.addEventListener else input.attachEvent

  addEventListenerWrapper = (type, listener) ->
    # Simulate a 'down arrow' keypress on hitting 'return' when no pac suggestion is selected, and then trigger the original listener.
    if type == 'keydown'
      orig_listener = listener

      listener = (event) ->
        suggestion_selected = $('.pac-item-selected').length > 0
        if event.which == 13 and !suggestion_selected
          simulated_downarrow = $.Event('keydown',
            keyCode: 40
            which: 40)
          orig_listener.apply input, [ simulated_downarrow ]
        orig_listener.apply input, [ event ]
        return

    _addEventListener.apply input, [
      type
      listener
    ]
    # add the modified listener
    return

  if input.addEventListener
    input.addEventListener = addEventListenerWrapper
  else if input.attachEvent
    input.attachEvent = addEventListenerWrapper
  return

#############################################################################
