
window.mapControls ?= {}

# Event listener:
mapControls.ready = ->
  # Insert initilization code here
  document.getElementById('search-input').focus()
  mapControls.branches = []
  mapControls.buttonListeners()

$(document).ready(mapControls.ready)
$(document).on('page:load', mapControls.ready)

#############################################################################

mapControls.initMap = () ->
  mapControls.defaultLocation = {lat: -33.455388, lng: -70.634216}
  mapControls.defaultZoom = 15
  mapControls.map = new (google.maps.Map)(document.getElementById('map'),
  zoom: mapControls.defaultZoom
  center: mapControls.defaultLocation
  styles: [{"featureType":"landscape","stylers":[{"hue":"#FFBB00"},{"saturation":43.400000000000006},{"lightness":37.599999999999994},{"gamma":1}]},{"featureType":"road.highway","stylers":[{"hue":"#FFC200"},{"saturation":-61.8},{"lightness":45.599999999999994},{"gamma":1}]},{"featureType":"road.arterial","stylers":[{"hue":"#FF0300"},{"saturation":-100},{"lightness":51.19999999999999},{"gamma":1}]},{"featureType":"road.local","stylers":[{"hue":"#FF0300"},{"saturation":-100},{"lightness":52},{"gamma":1}]},{"featureType":"water","stylers":[{"hue":"#0078FF"},{"saturation":-13.200000000000003},{"lightness":2.4000000000000057},{"gamma":1}]},{"featureType":"poi","stylers":[{"hue":"#00FF6A"},{"saturation":-1.0989010989011234},{"lightness":11.200000000000017},{"gamma":1}]}])

  options = {
    componentRestrictions: {country: "cl"}
  }
  input = document.getElementById('search-input')
  inputLeftPanel = document.getElementById('search-input-left-panel')

  mapControls.autocomplete = new google.maps.places.Autocomplete(input, options)
  mapControls.autocompleteLeftPanel = new google.maps.places.Autocomplete(inputLeftPanel, options)

  # Bind the map's bounds (viewport) property to the autocomplete object,
  # so that the autocomplete requests use the current map bounds for the
  # bounds option in the request.
  mapControls.autocomplete.bindTo('bounds', mapControls.map)
  mapControls.autocompleteLeftPanel.bindTo('bounds', mapControls.map)

  mapControls.infowindow = new google.maps.InfoWindow()

  mapControls.marker = new (google.maps.Marker)(
    map: mapControls.map
    anchorPoint: new (google.maps.Point)(0, -29))


#############################################################################

mapControls.buttonListeners = () ->
  input = document.getElementById('search-input')
  # Prevent double event if user press enter
  google.maps.event.addDomListener input, 'keydown', (e) ->
    if e.keyCode == 13
      e.preventDefault()
      e.stopPropagation()

  # Enable map change if user press enter instead button on floating initial modal
  mapControls.autocomplete.addListener 'place_changed', ->
    mapControls.infowindow.close()
    $('.map-search').click()

  # When user click on floating initial modal
  $('.map-search').click ->
    mapControls.userSearchAction(mapControls.marker, mapControls.autocomplete, 'basic-search-form')
    leftIinput = document.getElementById('search-input-left-panel')
    leftIinput.value = document.getElementById('search-input').value

  # when user click on basic search type on left panel
  $('.map-search-left-panel').click ->
    mapControls.userSearchAction(mapControls.marker, mapControls.autocompleteLeftPanel, 'basic-search-form')

  # when user click on advanced search type on left panel
  $('.advanced-map-search-left-panel').click ->
    mapControls.userSearchAction(mapControls.marker, mapControls.autocompleteLeftPanel, 'advanced-search-form')

#############################################################################

mapControls.userSearchAction = (marker, autocomplete, formToSubmit) ->
  mapControls.infowindow.close()
  mapControls.goToNewPlace(marker, autocomplete)
  $('#'+formToSubmit).submit()

#############################################################################

mapControls.goToNewPlace = (marker, autocomplete) ->
  marker.setVisible false
  place = autocomplete.getPlace()

  if !place && document.getElementById('search-input-left-panel').value == ''
    mapControls.map.setCenter mapControls.defaultLocation
  # If the place has a geometry, then present it on a map.
  else if place && place.geometry.viewport
    mapControls.map.fitBounds place.geometry.viewport
  else if place
    mapControls.map.setCenter place.geometry.location

  if place
    marker.setPosition place.geometry.location
    marker.setVisible false