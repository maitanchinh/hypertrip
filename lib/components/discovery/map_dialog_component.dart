import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/discovery/nearby_response.dart';

class MapDialog extends StatefulWidget {
  var lat, lng;
  NearbyPlacesResponse? places;
  bool nearby;
  var category;
  MapDialog(
      {super.key,
      this.lat,
      this.lng,
      this.places,
      this.nearby = false,
      this.category});

  @override
  State<MapDialog> createState() => _MapDialogState();
}

class _MapDialogState extends State<MapDialog> {
  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("marker_1"),
          position: LatLng(widget.lat, widget.lng),
          infoWindow: InfoWindow(
            title: 'Portland Art Museum',
            snippet:
                'Founded in 1892, the museum is located in downtown Portland',
          ),
        ),
      );
    });
  }

  Future<Position> getPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // return null;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
            height: context.height() * 0.6,
            width: context.width() * 0.8,
            child: widget.places != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(widget.lat, widget.lng),
                          zoom: 17.0,
                        ),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: true,
                        zoomGesturesEnabled: true,
                        markers: Set.from(widget.places!.results!.map((place) =>
                            Marker(
                                markerId: MarkerId(place.fsqId.toString()),
                                visible:
                                    widget.category == 'All'
                                        ? true
                                        : (place.categories!
                                                .where(
                                                    (item) => item.name!.contains(
                                                        widget.category))
                                                .toList()
                                                .isNotEmpty
                                            ? true
                                            : false),
                                position: LatLng(
                                    place.geocodes!.main!.latitude!.toDouble(),
                                    place.geocodes!.main!.longitude!
                                        .toDouble()),
                                infoWindow: InfoWindow(
                                    title: place.name,
                                    snippet: place.location!.address))))),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(widget.lat, widget.lng),
                          zoom: 17.0,
                        ),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: true,
                        zoomGesturesEnabled: true,
                        markers: _markers),
                  )));
  }
}
