
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


branchesControls.removeMarkers = () ->
  for marker in branchesControls.markers
    marker.setMap(null)
  branchesControls.markers = []