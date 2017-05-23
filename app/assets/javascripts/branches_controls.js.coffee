
window.branchesControls ?= {}

# Event listener:
branchesControls.ready = ->
  # Insert initilization code here
  branchesControls.branches = []
  branchesControls.markers = []

$(document).ready(branchesControls.ready)
$(document).on('page:load', branchesControls.ready)

#############################################################################

branchesControls.drawBranches = () ->
  branchesControls.removeMarkers()
  for branch in branchesControls.branches
    marker = new (google.maps.Marker)(
      position: new (google.maps.LatLng)(branch[2], branch[3])
      map: mapControls.map
      animation: google.maps.Animation.DROP
      icon: marker =
        url: branch[4]
        scaledSize: new (google.maps.Size)(35, 40)
      title: branch[1]
      id: branch[0])
    branchesControls.markers.push(marker)
    branchesControls.setJumpingmarker(marker, branch[5])

#############################################################################

branchesControls.removeMarkers = () ->
  for marker in branchesControls.markers
    marker.setMap(null)
  branchesControls.markers = []

#############################################################################

branchesControls.setJumpingmarker = (marker, milliseconds_between_jumps) ->
  setTimeout (->
    branchesControls.jumpOnce(marker)
    branchesControls.setJumpingmarker(marker, milliseconds_between_jumps)
  ), milliseconds_between_jumps

#############################################################################

branchesControls.jumpOnce = (marker) ->
  if marker.getAnimation() != null
    marker.setAnimation(null)
  else
    marker.setAnimation(google.maps.Animation.BOUNCE);
    setTimeout (->
      marker.setAnimation null
    ), 700
