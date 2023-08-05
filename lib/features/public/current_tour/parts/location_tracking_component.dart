part of '../view.dart';

class LocationTrackingComponent extends StatefulWidget {
  final List<Slot> slots;
  const LocationTrackingComponent({super.key, required this.slots});

  @override
  State<LocationTrackingComponent> createState() =>
      _LocationTrackingComponentState();
}

class _LocationTrackingComponentState extends State<LocationTrackingComponent> {
  late GoogleMapController _mapController;
  late StreamSubscription<Position>? _positionStreamSubscription;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  // Future<Position>? _latlng;
  late Position _position = const Position(
      latitude: 0,
      longitude: 0,
      accuracy: 0,
      heading: 0,
      speed: 0,
      altitude: 0,
      speedAccuracy: 0,
      timestamp: null);
  final List<LatLng> _polylineCoordinate = [];
  final Set<Marker> _markers = {};
  int _currentLocationIndex = -1;
  MapsRoutes route = MapsRoutes();
  DistanceCalculator distanceCalculator = DistanceCalculator();
  // String googleApiKey = 'AIzaSyCrnkFUjP4YhaT9OPfRyP_3trttqauSHlY';
  String googleApiKey = '';

  @override
  void initState() {
    // _latlng = _getCurrentLocation();
    setCustomMarkerIcon();
    getPolypoints();
    getDirection();
    super.initState();
  }

  void _startLocationUpdates() {
    _positionStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        _position = position;
      });
    });
  }

  void _stopLocationUpdates() {
    _positionStreamSubscription?.cancel();
  }

  // Future<Position> _getCurrentLocation() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission != LocationPermission.whileInUse &&
  //         permission != LocationPermission.always) {}
  //   }

  //   _startLocationUpdates();

  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );

  //   _position = position;
  //   return position;
  // }

  void _moveToNextLocation() {
    setState(() {
      if (_currentLocationIndex < widget.slots.length - 1) {
        _currentLocationIndex++;
        _moveCamera();
      }
    });
  }

  void _moveToPreviousLocation() {
    setState(() {
      if (_currentLocationIndex > 0) {
        _currentLocationIndex--;
        _moveCamera();
      }
    });
  }

  void _moveCamera() {
    final currentLocation = widget.slots[_currentLocationIndex];
    getPolypoints();
    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(currentLocation.latitude as double,
            currentLocation.longitude as double),
        12,
      ),
    );
  }

  void _moveCameraToCurrentLocation() {
    setState(() {
      _currentLocationIndex = -1;
    });
    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(_position.latitude, _position.longitude),
        12,
      ),
    );
  }

  @override
  void dispose() {
    _stopLocationUpdates();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
  }

  void getDirection() async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PolylineWayPoint> wayPoints = [];
    List<Slot> tourSubList =
        widget.slots.toList().sublist(1, widget.slots.toList().length - 1);
    tourSubList.toList().asMap().forEach((index, value) {
      PolylineWayPoint wayPoint = PolylineWayPoint(
        location: '${value.latitude},${value.longitude}',
        stopOver: true, // Specify if this waypoint is a stopover or not
      );

      // Add the waypoint to the list
      wayPoints.add(wayPoint);
    });
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(
            widget.slots.first.latitude!, widget.slots.first.longitude!),
        PointLatLng(widget.slots.last.latitude!, widget.slots.last.longitude!),
        travelMode: TravelMode.walking,
        wayPoints: wayPoints);
    if (result.points.isNotEmpty) {
      setState(() {
        for (var point in result.points) {
          _polylineCoordinate.add(LatLng(point.latitude, point.longitude));
        }
      });
    }
  }

  void getPolypoints() async {
    widget.slots.asMap().forEach((index, position) async {
      double? lat = position.latitude;
      double? lng = position.longitude;
      if (lat != null && lng != null) {
        Uint8List canvas =
            await getBytesFromCanvas(index + 1, _currentLocationIndex == index);
        setState(() {
          LatLng latLng = LatLng(lat.toDouble(), lng.toDouble());
          _markers.add(Marker(
              markerId: MarkerId('tour_location: ${position.id}'),
              infoWindow: InfoWindow(snippet: position.description, title: 'Day ${position.dayNo}'),
              position: latLng,
              icon: BitmapDescriptor.fromBytes(canvas),
              anchor: const Offset(0.5, 1.0),
              onTap: (){
                showMaterialModalBottomSheet(expand: true, context: context, builder: (context) => Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(16)), color: yellow),
                  height: 300,
                  child: Text(position.description.toString()),
                ));
              }));
        });
      }
    });
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, 'assets/images/airplane_marker.png')
        .then((icon) => currentLocationIcon = icon);
  }

  Future<Uint8List> getBytesFromCanvas(int number, bool isCurrent) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    // Set the circle color and size
    final circlePaint = Paint()
      ..color = isCurrent ? AppColors.secondaryColor : AppColors.primaryColor;
    final circleRadius = isCurrent ? 60.0 : 40.0;

    // Set the number color and size
    final numberTextSpan = TextSpan(
      text: number.toString(),
      style: TextStyle(
        color: Colors.white,
        fontSize: isCurrent ? 50.0 : 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
    final numberTextPainter = TextPainter(
      text: numberTextSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    numberTextPainter.layout();
    final numberOffset = Offset(
      circleRadius - numberTextPainter.width / 2,
      circleRadius - numberTextPainter.height / 2,
    );

    // Set the point color and size
    final pointPaint = Paint()
      ..color = isCurrent ? AppColors.secondaryColor : AppColors.primaryColor
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;
    final pointStart = Offset(
      circleRadius,
      circleRadius + 40.0,
    );
    final pointEnd = Offset(
      circleRadius,
      isCurrent ? circleRadius + 120 : circleRadius + 60.0,
    );

    // Draw the circle, number, and point on the canvas
    canvas.drawCircle(
      Offset(circleRadius, circleRadius),
      circleRadius,
      circlePaint,
    );
    numberTextPainter.paint(canvas, numberOffset);
    canvas.drawLine(pointStart, pointEnd, pointPaint);

    // Convert the canvas to an image and return its bytes
    final picture = pictureRecorder.endRecording();
    final img = await picture.toImage(
      (circleRadius * 2).toInt(),
      ((circleRadius * 2) + 50.0).toInt(),
    );
    final pngBytes = await img.toByteData(format: ImageByteFormat.png);
    return pngBytes!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<Position>(
    //     future: _latlng,
    //     builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
    //       if (!snapshot.hasData) {
    //         return SizedBox(
    //           height: context.height() * 0.5,
    //           child: const Center(
    //             child: CircularProgressIndicator(),
    //           ),
    //         );
    //       } else {
    //         final latlng = snapshot.data!;
    final cubit = BlocProvider.of<CurrentLocationCubit>(context);
  
            return Scaffold(
              floatingActionButton: ExpandableFab(
                  type: ExpandableFabType.left,
                  distance: 50,
                  backgroundColor: AppColors.primaryColor,
                  closeButtonStyle: const ExpandableFabCloseButtonStyle(
                      backgroundColor: AppColors.secondaryColor),
                  children: [
                    FloatingActionButton.small(
                      onPressed: _moveToNextLocation,
                      backgroundColor: AppColors.primaryColor,
                      child: SvgPicture.asset(
                        Resource.iconsAngleRight,
                        width: 14,
                        color: white,
                      ),
                    ),
                    FloatingActionButton.small(
                      onPressed: _moveCameraToCurrentLocation,
                      // onPressed: () {},
                      backgroundColor: AppColors.primaryColor,
                      child: SvgPicture.asset(
                        Resource.iconsLocationArrow,
                        width: 18,
                        color: white,
                      ),
                    ),
                    FloatingActionButton.small(
                      onPressed: _moveToPreviousLocation,
                      backgroundColor: AppColors.primaryColor,
                      child: SvgPicture.asset(
                        Resource.iconsAngleLeft,
                        width: 14,
                        color: white,
                      ),
                    ),
                  ]),
              floatingActionButtonLocation: ExpandableFab.location,
              body: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                      target: LatLng((cubit.state as LoadCurrentLocationSuccessState).location.latitude, (cubit.state as LoadCurrentLocationSuccessState).location.longitude),
                      zoom: 12.0),
                  polylines:
                      // route.routes,

                      {
                    Polyline(
                        polylineId: const PolylineId('route'),
                        points: _polylineCoordinate,
                        color: AppColors.primaryColor,
                        width: 6)
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  markers: _markers),
            );
        //   }
        // });
  }
}
