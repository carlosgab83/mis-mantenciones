
window.branchesControls ?= {}

# Event listener:
branchesControls.ready = ->
  # Insert initilization code here
  if typeof google != 'undefined'
    branchesControls.initilization()
    branchesControls.afterLoadHook()

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
  branchesControls.BRANCH_TYPES_IDS = 7 # Multi type
  branchesControls.BRANCH_SLUG = 8

  branchesControls.branches = []
  branchesControls.associativeMarkers = {}
  branchesControls.timersForMarkers = {}

  branchesControls.markerClusterer = branchesControls.markerClusterer = new MarkerClusterer(mapControls.map, [], {imagePath: ''})


  $('#branch_types-filters input').click ->

    # uncheck _select_all if apply
    if(!this.checked)
      $('#branch_types-filters input[value="_select_all"]')[0].checked =  false

    # check _select_all if apply
    if($('#branch_types-filters input:not(:checked)').length == 1 && this.value != '_select_all')
      $('#branch_types-filters input:not(:checked)')[0].checked =  true

    generalControls.showLoadingEffect()
    setTimeout (->
      branchesControls.drawBranches()
      generalControls.hideLoadingEffect()
      leftPanelControls.storeNewUserSelection()
    ), 500

#############################################################################

branchesControls.drawBranches = () ->
  timestamp = new Date().getTime()

  # Insert or update markers
  branchesControls.stopAllJumpingMarkers()
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
  branchesControls.stopAllJumpingMarkers()
  branchesControls.markerClusterer = new MarkerClusterer(mapControls.map, markers, {imagePath: mapControls.markerClustererImagePath, minimumClusterSize: 8})

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
  branchTypesIds = Array.from(marker.customInfo['branch'][branchesControls.BRANCH_TYPES_IDS])
  branchTypesIds.push(branchTypeId)

  for eachBranchTypeId in branchTypesIds
    checkbox = $('#branch_types-filters input[value=' + eachBranchTypeId + ']')[0]
    if checkbox != null && checkbox.checked
      return true

  return false

#############################################################################

branchesControls.stopAllJumpingMarkers = () ->
  for markerId, timer of branchesControls.timersForMarkers
    clearTimeout(timer)

#############################################################################

# This method is called from markerclusterer.js
branchesControls.setJumpingMarker = (marker) ->
  return setTimeout (->
    if marker.getMap() != null && marker.customInfo['branch'][branchesControls.INTERVAL_BETWEEN_JUMPS] > 0
      branchesControls.jumpOnce(marker)
      branchesControls.timersForMarkers[marker.id] = branchesControls.setJumpingMarker(marker, marker.customInfo['branch'][branchesControls.INTERVAL_BETWEEN_JUMPS])
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
  url = '/search-branches/' + marker.customInfo['branch'][branchesControls.BRANCH_SLUG]
  url = url + '?search[brand_id]=' + $('#search_brand_id').val()
  url = url + '&search[model_id]=' + $('#search_model_id').val()
  url = url + '&search[patent]=' + $('#search_patent').val()
  url = url + '&search[kms]=' + $('#search_kms').val()
  method ="GET"
  success_function = ->
  generalControls.sendAjax(params, url, success_function, method)

##############################################################################

branchesControls.centerMarker = (markerId) ->
  marker = branchesControls.associativeMarkers[markerId]
  if marker
    mapControls.map.panTo(marker.getPosition())

##############################################################################

branchesControls.afterLoadHook = () ->
  # This function is overwriten by rails views dinamically

##############################################################################
