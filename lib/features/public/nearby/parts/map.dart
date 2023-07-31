part of '../view.dart';

class NearbyMap extends StatefulWidget {
  static const String routeName = '/nearby-map';
  final List<NearbyResults>? places;
  const NearbyMap({super.key, required this.places});
  NearbyMap.fromObject({super.key, required NearbyResults place})
      : places = [place];
  @override
  State<NearbyMap> createState() => _NearbyMapState();
}

class _NearbyMapState extends State<NearbyMap> {
  late GoogleMapController _mapController;
  final Set<Marker> _marker = {};
  @override
  void initState() {
    _marker.addAll(widget.places!.map(
      (place) => Marker(
        markerId: MarkerId(place.fsqId.toString()),
        position: LatLng(
          place.geocodes!.main!.latitude!.toDouble(),
          place.geocodes!.main!.longitude!.toDouble(),
        ),
        infoWindow: InfoWindow(
          title: place.name,
        ),
      ),
    ));
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
  }

  void _moveCameraToCurrentLocation(Position location) {
    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(location.latitude, location.longitude),
        12,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CurrentLocationCubit>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const MainAppBar(
        implyLeading: true,
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: AppColors.primaryLightColor,
        elevation: 0,
        child: SvgPicture.asset(AppAssets.icons_location_arrow_svg, color: AppColors.primaryColor, width: 20,),
        onPressed: () {
        _moveCameraToCurrentLocation(
            (cubit.state as LoadCurrentLocationSuccessState).location);
      }),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
            target: LatLng(
                (cubit.state as LoadCurrentLocationSuccessState)
                    .location
                    .latitude,
                (cubit.state as LoadCurrentLocationSuccessState)
                    .location
                    .longitude),
            zoom: 12),
        markers: _marker,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
      ),
    );
  }
}
