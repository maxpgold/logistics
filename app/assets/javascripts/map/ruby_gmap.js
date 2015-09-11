RubyGmap = {    
setPosition: function(marker) {
    $('#latitude_field').val(marker.getLatLng().lat());
    $('#longitude_field').val(marker.getLatLng().lng());
},
setMarkerPosition: function(marker, latlng) {
    SELECTED = true;
    map.addOverlay(marker);
    marker.setLatLng(latlng);
    RubyGmap.setPosition(marker);
}
}