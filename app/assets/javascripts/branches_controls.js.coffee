
window.branchesControls ?= {}

# Event listener:
branchesControls.ready = ->
  # Insert initilization code here
  if typeof google != 'undefined'
    branchesControls.initilization()

$(document).ready(branchesControls.ready)
$(document).on('page:load', branchesControls.ready)

#############################################################################

branchesControls.initilization = () ->
  # Constants
  branchesControls.ID = 0
  branchesControls.NAME = 1
  branchesControls.LAT = 2
  branchesControls.LNG = 3
  branchesControls.MARKER_URL = 4
  branchesControls.INTERVAL_BETWEEN_JUMPS = 5
  branchesControls.BRANCH_TYPE_ID = 6

  branchesControls.branches = []
  branchesControls.associativeMarkers = {}
  branchesControls.markerClusterer = branchesControls.markerClusterer = new MarkerClusterer(mapControls.map, [], {imagePath: ''})


  $('#branch_types-filters input').click ->
    branchesControls.drawBranches()

#############################################################################

branchesControls.drawBranches = () ->
  timestamp = new Date().getTime()

  # Insert or update markers
  for branch in branchesControls.branches
    oldMarker = branchesControls.associativeMarkers[branch[branchesControls.ID]]
    if(oldMarker)
      branchesControls.updateOldMarker(oldMarker, branch)
      oldMarker.customInfo['timestamp'] = timestamp
    else
      # Is a non-existent (new) marker. Must be inserted
      marker = branchesControls.insertNewMarker(branch)
      if marker
        branchesControls.associativeMarkers[branch[branchesControls.ID]] = marker
        marker.customInfo['timestamp'] = timestamp

  # Delete deprecated markers (not longer nedeed because last search)
  for markerId, marker of branchesControls.associativeMarkers
    if branchesControls.associativeMarkers[markerId].customInfo['timestamp'] != timestamp
      branchesControls.associativeMarkers[markerId].setMap(null)
      delete(branchesControls.associativeMarkers[markerId])

  markers = []
  for markerId, marker of branchesControls.associativeMarkers
    markers.push(marker)

  return markers

#############################################################################

branchesControls.makeCluster = (markers) ->
  branchesControls.markerClusterer.clearMarkers()
  branchesControls.markerClusterer = new MarkerClusterer(mapControls.map, markers, {imagePath: mapControls.markerClustererImagePath})

#############################################################################

branchesControls.updateOldMarker = (marker, branch) ->
  marker.position = new (google.maps.LatLng)(branch[branchesControls.LAT], branch[branchesControls.LNG])
  marker.icon =
    url: branch[branchesControls.MARKER_URL]
    scaledSize: new (google.maps.Size)(35, 40)
  marker.title = branch[branchesControls.NAME]
  marker.customInfo = {branch: branch}

  # Marker must be drawn depending on left filter selection (branch type)
  if branchesControls.markerMustBeDrawn(marker)
    if branchesControls.associativeMarkers[marker.id]
      branchesControls.markerClusterer.removeMarker(marker)

    branchesControls.markerClusterer.addMarker(marker)
    return marker
  else
    delete(branchesControls.associativeMarkers[marker.id])
    branchesControls.markerClusterer.removeMarker(marker)

#############################################################################

branchesControls.insertNewMarker = (branch) ->
  marker = new (google.maps.Marker)(
    position: new (google.maps.LatLng)(branch[branchesControls.LAT], branch[branchesControls.LNG])
    animation: google.maps.Animation.DROP
    icon: marker =
      url: branch[branchesControls.MARKER_URL]
      scaledSize: new (google.maps.Size)(35, 40)
    title: branch[branchesControls.NAME]
    id: branch[branchesControls.ID]
    customInfo: {branch: branch})

  marker.addListener('click', ->
    branchesControls.clickOnMarker(marker)
    )

  if branchesControls.markerMustBeDrawn(marker)
    branchesControls.markerClusterer.addMarker(marker)
  else
    return null
  return marker

#############################################################################

branchesControls.markerMustBeDrawn = (marker) ->
  branchTypeId = marker.customInfo['branch'][branchesControls.BRANCH_TYPE_ID]
  checkbox = $('#branch_types-filters input[value=' + branchTypeId + ']')[0]
  if checkbox == null
    return false
  return checkbox.checked

#############################################################################

# This method is called from markerclusterer.js
branchesControls.setJumpingMarker = (marker) ->
  setTimeout (->
    if marker.getMap() != null && marker.customInfo['branch'][branchesControls.INTERVAL_BETWEEN_JUMPS] > 0
      branchesControls.jumpOnce(marker)
      branchesControls.setJumpingMarker(marker, marker.customInfo['branch'][branchesControls.INTERVAL_BETWEEN_JUMPS])
  ), marker.customInfo['branch'][branchesControls.INTERVAL_BETWEEN_JUMPS]

#############################################################################

branchesControls.jumpOnce = (marker) ->
  if marker.getAnimation() != null
    marker.setAnimation(null)
  else
    marker.setAnimation(google.maps.Animation.BOUNCE);
    setTimeout (->
      marker.setAnimation null
    ), 700

##############################################################################

branchesControls.clickOnMarker = (marker) ->
  params = {}
  url = '/search-branches/' + marker.id
  method ="GET"
  success_function = ->
  generalControls.sendAjax(params, url, success_function, method)

##############################################################################