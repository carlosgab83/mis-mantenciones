
window.branchesControls ?= {}

# Event listener:
branchesControls.ready = ->
  # Insert initilization code here
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

  $('#branch_types-filters input').click ->
    branchesControls.filterBranches(this)

#############################################################################

branchesControls.drawBranches = () ->
  timestamp = new Date().getTime()

  # Insert or update markers
  for branch in branchesControls.branches
    oldMarker = branchesControls.associativeMarkers[branch[branchesControls.ID]]
    if(oldMarker)
      branchesControls.updateOldMarker(oldMarker, branch)
      oldMarker.customInfo['timestamp'] = timestamp
      console.log('appliyng timestamp to'+branch[branchesControls.ID])
    else
      # Is a non-existent (new) marker. Must to be inserted
      marker = branchesControls.insertNewMarker(branch)
      branchesControls.associativeMarkers[branch[branchesControls.ID]] = marker
      marker.customInfo['timestamp'] = timestamp

  # Delete deprecated markers (not longer nedeed because last search)
  for markerId, marker of branchesControls.associativeMarkers
    if branchesControls.associativeMarkers[markerId].customInfo['timestamp'] != timestamp
      branchesControls.associativeMarkers[markerId].setMap(null)
      delete(branchesControls.associativeMarkers[markerId])

#############################################################################

branchesControls.updateOldMarker = (marker, branch) ->
  marker.position = new (google.maps.LatLng)(branch[branchesControls.LAT], branch[branchesControls.LNG])
  marker.icon =
    url: branch[branchesControls.MARKER_URL]
    scaledSize: new (google.maps.Size)(35, 40)
  marker.title = branch[branchesControls.NAME]
  marker.customInfo = {branch: branch}

  # marker must be drawn depending on left filter selection (branch type)
  if branchesControls.markerMustBeDrawn(marker)
    if marker.getMap() == null
      marker.setMap(mapControls.map)
  else
    marker.setMap(null)

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

  if branchesControls.markerMustBeDrawn(marker)
    marker.setMap(mapControls.map)
  else
    marker.setMap(null)

  branchesControls.setJumpingMarker(marker)
  return marker

#############################################################################

branchesControls.markerMustBeDrawn = (marker) ->
  branchTypeId = marker.customInfo['branch'][branchesControls.BRANCH_TYPE_ID]
  checkbox = $('#branch_types-filters input[value=' + branchTypeId + ']')[0]
  if checkbox == null
    return false
  return checkbox.checked

#############################################################################

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

branchesControls.filterBranches = (checkbox) ->
  branchTypeId = checkbox.value
  checked = checkbox.checked
  for markerId, marker of branchesControls.associativeMarkers
    if String(branchesControls.associativeMarkers[markerId].customInfo['branch'][branchesControls.BRANCH_TYPE_ID]) == branchTypeId
      if checked
        branchesControls.associativeMarkers[markerId].setMap(mapControls.map)
        branchesControls.setJumpingMarker(marker)
      else
        branchesControls.associativeMarkers[markerId].setMap(null)

##############################################################################