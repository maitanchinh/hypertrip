part of '../view.dart';

class LocationTracking extends StatefulWidget {
  final List<Slot> slots;
  const LocationTracking({super.key, required this.slots});

  @override
  State<LocationTracking> createState() => _LocationTrackingState();
}

class _LocationTrackingState extends State<LocationTracking> {
  late GoogleMapController _mapController;
  late StreamSubscription<Position>? _positionStreamSubscription;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  final _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
    final cubit = BlocProvider.of<CurrentLocationCubit>(context);
    _position = (cubit.state as LoadCurrentLocationSuccessState).location;
    setCustomMarkerIcon();
    getPolypoints();
    getDirection();
    super.initState();
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
              infoWindow: InfoWindow(
                  snippet: position.description,
                  title: 'Day ${position.dayNo}'),
              position: latLng,
              icon: BitmapDescriptor.fromBytes(canvas),
              anchor: const Offset(0.5, 1.0),
              onTap: () {
                showCupertinoModalBottomSheet(
                    expand: true,
                    context: context,
                    builder: (context) => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16))),
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
    int indexOfSchedule = _currentLocationIndex < 0
        ? _currentLocationIndex + 1
        : _currentLocationIndex;
    Slot schedule = widget.slots[indexOfSchedule];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SearchBar(
        scaffoldKey: _scaffoldKey,
        searchController: _searchController,
        focusNode: _focusNode,
      ),
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
                AppAssets.icons_angle_right_svg,
                width: 14,
                color: white,
              ),
            ),
            FloatingActionButton.small(
              onPressed: _moveCameraToCurrentLocation,
              // onPressed: () {},
              backgroundColor: AppColors.primaryColor,
              child: SvgPicture.asset(
                AppAssets.icons_location_arrow_svg,
                width: 18,
                color: white,
              ),
            ),
            FloatingActionButton.small(
              onPressed: _moveToPreviousLocation,
              backgroundColor: AppColors.primaryColor,
              child: SvgPicture.asset(
                AppAssets.icons_angle_left_svg,
                width: 14,
                color: white,
              ),
            ),
          ]),
      floatingActionButtonLocation: ExpandableFab.location,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 32,
            child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        (cubit.state as LoadCurrentLocationSuccessState)
                            .location
                            .latitude,
                        (cubit.state as LoadCurrentLocationSuccessState)
                            .location
                            .longitude),
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
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: context.height(),
            child: SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.1,
                minChildSize: 0.1,
                maxChildSize: 0.7,
                builder: (context, ScrollController scrollController) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: const BoxDecoration(
                        color: white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16))),
                    child: ListView(
                        padding: EdgeInsets.zero,
                        controller: scrollController,
                        children: [
                          Center(
                            child: Container(
                              height: 4,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: AppColors.textGreyColor,
                                  borderRadius: BorderRadius.circular(2)),
                            ),
                          ),
                          Gap.k16.height,
                          SafeSpace(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PSmallText(
                                schedule.description,
                                color: AppColors.greyColor,
                              ),
                              Gap.k16.height,
                              Row(
                                children: [
                                  SizedBox(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.icons_calendar_svg,
                                          height: 14,
                                          color: AppColors.greyColor,
                                        ),
                                        Gap.k8.width,
                                        PSmallText('Day',
                                            color: AppColors.greyColor),
                                        Gap.k4.width,
                                        PSmallText(
                                          schedule.dayNo.toString(),
                                          color: AppColors.greyColor,
                                        ),
                                        Gap.k8.width,
                                        Container(
                                          height: 3,
                                          width: 3,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.greyColor),
                                        ),
                                        Gap.k8.width,
                                        schedule.vehicle == 'Airplane'
                                            ? SvgPicture.asset(AppAssets
                                                .icons_plane_departure_svg,
                                                height: 14,
                                                color: AppColors.greyColor,)
                                            : schedule.vehicle == 'Motorbike'
                                                ? SvgPicture.asset(AppAssets
                                                    .icons_motorcycle_svg,
                                                    height: 14,
                                                    color: AppColors.greyColor,)
                                                : schedule.vehicle == 'Car'
                                                    ? SvgPicture.asset(AppAssets
                                                        .icons_car_side_svg,
                                                        height: 14,
                                                        color: AppColors.greyColor,)
                                                    : schedule.vehicle == 'Bus'
                                                        ? SvgPicture.asset(
                                                            AppAssets
                                                                .icons_bus_svg,
                                                                height: 14,
                                                                color: AppColors.greyColor,)
                                                        : schedule.vehicle ==
                                                                'Boat'
                                                            ? SvgPicture.asset(
                                                                AppAssets
                                                                    .icons_sailboat_svg,
                                                                    height: 14,
                                                                    color: AppColors.greyColor,)
                                                            : SvgPicture.asset(
                                                                AppAssets
                                                                    .icons_train_svg,
                                                                    height: 14,
                                                                    color: AppColors.greyColor,),
                                                                    Gap.k8.width,
                                                                    PSmallText('Come by ' + schedule.vehicle.toString(), color: AppColors.greyColor,)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Gap.kSection.height,
                              PText('Nearby'),
                              Gap.k16.height,
                              

                            ],
                          ))
                        ]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
    //   }
    // });
  }
}

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final TextEditingController searchController;
  final FocusNode focusNode;
  const SearchBar(
      {super.key,
      required this.scaffoldKey,
      required this.searchController,
      required this.focusNode});

  @override
  State<SearchBar> createState() => _SearchBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(92);
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<NearbyPlaceCubit>(context);
    final currentLocationCubit = BlocProvider.of<CurrentLocationCubit>(context);

    return SafeArea(
      child: Column(
        children: [
          SafeSpace(
            child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ], color: whiteColor, borderRadius: BorderRadius.circular(50)),
                child: TextField(
                  controller: widget.searchController,
                  focusNode: widget.focusNode,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Search for a place',
                    prefixIcon: SizedBox(
                      width: 16,
                      height: 16,
                      child: Transform.scale(
                        scale: 0.5,
                        child: SvgPicture.asset(
                          AppAssets.icons_search_svg,
                          // width: 16,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) {
                    cubit.getNearbyPlace(widget.searchController.text);
                    showCupertinoModalBottomSheet(
                        context: context,
                        builder: (context) => BlocProvider(
                            create: (context) => NearbyPlaceCubit(
                                currentLocationCubit,
                                widget.searchController.text),
                            child: NearbyPlaceList(
                                query: widget.searchController.text)));
                    // _resetChildState();
                    // setState(() {
                    //   query = _searchController.text;
                    //   _resetChild = true;
                    // });
                  },
                )),
          ),
          Gap.k8.height,
          _category(context)
        ],
      ),
    );
  }

  // // TODO: implement preferredSize
  // Size get preferredSize => const Size.fromHeight(56.0);

  List catNames = ["Food", "Coffee", "NightLife", "Shopping"];
  String query = '';
  List<SvgPicture> catIcons = [
    SvgPicture.asset(
      AppAssets.icons_fork_knife_svg,
      height: 16,
    ),
    SvgPicture.asset(
      height: 16,
      AppAssets.icons_mug_saucer_svg,
    ),
    SvgPicture.asset(
      AppAssets.icons_champagne_glass_svg,
      height: 16,
    ),
    SvgPicture.asset(
      height: 16,
      AppAssets.icons_cart_shopping_svg,
    ),
  ];

  Widget _category(BuildContext context) {
    final cubit = BlocProvider.of<NearbyPlaceCubit>(context);
    final currentLocationCubit = BlocProvider.of<CurrentLocationCubit>(context);
    return SizedBox(
      height: 36,
      width: context.width(),
      child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: catNames.length,
          itemBuilder: (context, index) {
            return Card(
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 8),
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    catIcons[index],
                    Gap.k8.width,
                    PText(
                      catNames[index],
                      size: 12,
                    ),
                  ],
                ),
              ),
            ).onTap(() {
              // _resetChildState();
              cubit.getNearbyPlace(catNames[index]);
              showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) => BlocProvider(
                      create: (context) => NearbyPlaceCubit(
                          currentLocationCubit, catNames[index]),
                      child: NearbyPlaceList(query: catNames[index])));
            });
          }),
    );
  }
}
