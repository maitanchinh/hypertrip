part of '../view.dart';

class LocationTracking extends StatefulWidget {
  final List<Slot> slots;
  const LocationTracking({super.key, required this.slots});

  @override
  State<LocationTracking> createState() => _LocationTrackingState();
}

class _LocationTrackingState extends State<LocationTracking> {
  late GoogleMapController _mapController;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  final _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
  Key _childKey = UniqueKey();
  late Slot currentPlaceOnSchedule = widget.slots.first;
    
  @override
  void initState() {
    // _latlng = _getCurrentLocation();
    final cubit = BlocProvider.of<CurrentLocationCubit>(context);
    _position = (cubit.state as LoadCurrentLocationSuccessState).location;
    _currentPlaceOnSchedule();
    setCustomMarkerIcon();
    getPolypoints();
    getDirection();
    super.initState();
  }

  void _currentPlaceOnSchedule(){
    final currentTourCubit = BlocProvider.of<CurrentTourCubit>(context);

    var currentScheduleId =
        (currentTourCubit.state as LoadCurrentTourSuccessState)
            .group
            .currentScheduleId;
    var slots =
        (currentTourCubit.state as LoadCurrentTourSuccessState).schedule;
    Slot? desiredSlot =
        slots.firstWhereOrNull((slot) => slot.id == currentScheduleId);
    if (desiredSlot != null) {
      if (desiredSlot.longitude == null || desiredSlot.latitude == null) {
        int desiredSequence = desiredSlot.sequence!;
        Slot? nearestSlot = slots.reversed.firstWhereOrNull((slot) =>
            slot.sequence! < desiredSequence &&
            slot.longitude != null &&
            slot.latitude != null);

        if (nearestSlot != null) {
          currentPlaceOnSchedule = nearestSlot;
          List<Slot> tourSubList = widget.slots
              .toList()
              .sublist(1, widget.slots.toList().length - 1);
              _currentLocationIndex = tourSubList.indexWhere((element) => element.id == nearestSlot.id) + 1;
          print('Nearest point : ${currentPlaceOnSchedule.sequence}');
        } else {
          print('No previous point with valid longitude and latitude found');
        }
      } else {
        currentPlaceOnSchedule = desiredSlot;
      }
    } else {
      print('Slot with ID $currentScheduleId not found');
    }
  }

  void _resetChildState() {
    setState(() {
      _childKey = UniqueKey(); // Update the key to trigger a rebuild
    });
  }

  void _moveToNextLocation() {
    // _resetChildState();
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
    _resetChildState();
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

  void _moveCameraToCurrentSchedule() {
    getPolypoints();
    // _resetChildState();
    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(currentPlaceOnSchedule.latitude!, currentPlaceOnSchedule.longitude!),
        12,
      ),
    );
  }

  @override
  void dispose() {
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
                snippet: position.description, title: 'Day ${position.dayNo}'),
            position: latLng,
            icon: BitmapDescriptor.fromBytes(canvas),
            anchor: const Offset(0.5, 1.0),
          ));
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
    final currentTourCubit = BlocProvider.of<CurrentTourCubit>(context);
    // final nearbyPlaceSuggestionCubit = BlocProvider.of<NearbyPlaceSuggestionCubit>(context);
    int indexOfSchedule = _currentLocationIndex < 0
        ? _currentLocationIndex + 1
        : _currentLocationIndex;
    Slot schedule = widget.slots[indexOfSchedule];
    return _buildePage(
        cubit, currentTourCubit, context, schedule, _currentLocationIndex);
    //   }
    // });
  }

  Scaffold _buildePage(
      CurrentLocationCubit cubit,
      CurrentTourCubit currentTourCubit,
      BuildContext context,
      Slot schedule,
      int index) {
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SearchBar(
        scaffoldKey: _scaffoldKey,
        searchController: _searchController,
        focusNode: _focusNode,
        currentLocationIndex: index,
        schedule: schedule,
        currentLocation: _position,
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
              onPressed: _moveCameraToCurrentSchedule,
              // onPressed: () {},
              backgroundColor: AppColors.primaryColor,
              child: SvgPicture.asset(
                AppAssets.icons_map_pin_svg,
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
                    target: LatLng(currentPlaceOnSchedule.latitude!,
                        currentPlaceOnSchedule.longitude!),
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
                  // nearbyPlaceSuggestionCubit.getNearbyPlaceSuggestion(Position(longitude: schedule.latitude!.toDouble(), latitude: schedule.longitude!.toDouble(), timestamp: null, accuracy: 0, altitude: 0, heading: 0, speed: 0, speedAccuracy: 0));
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
                              if (currentPlaceOnSchedule.imageUrl != null)
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: FadeInImage.assetNetwork(
                                        placeholder: AppAssets.placeholder_png,
                                        image:
                                            currentPlaceOnSchedule.imageUrl!)),
                              if (currentPlaceOnSchedule.imageUrl != null)
                                Gap.k16.height
                              else
                                const SizedBox.shrink(),
                              PText(currentPlaceOnSchedule.title),
                              Gap.k16.height,
                              PSmallText(
                                currentPlaceOnSchedule.description,
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
                                        const PSmallText('Day',
                                            color: AppColors.greyColor),
                                        Gap.k4.width,
                                        PSmallText(
                                          currentPlaceOnSchedule.dayNo
                                              .toString(),
                                          color: AppColors.greyColor,
                                        ),
                                        currentPlaceOnSchedule.vehicle != null
                                            ? Row(
                                                children: [
                                                  Gap.k8.width,
                                                  Container(
                                                    height: 3,
                                                    width: 3,
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: AppColors
                                                                .greyColor),
                                                  ),
                                                  Gap.k8.width,
                                                  currentPlaceOnSchedule
                                                              .vehicle ==
                                                          'Airplane'
                                                      ? SvgPicture.asset(
                                                          AppAssets
                                                              .icons_plane_departure_svg,
                                                          height: 14,
                                                          color: AppColors
                                                              .greyColor,
                                                        )
                                                      : currentPlaceOnSchedule
                                                                  .vehicle ==
                                                              'Motorbike'
                                                          ? SvgPicture.asset(
                                                              AppAssets
                                                                  .icons_motorcycle_svg,
                                                              height: 14,
                                                              color: AppColors
                                                                  .greyColor,
                                                            )
                                                          : currentPlaceOnSchedule
                                                                      .vehicle ==
                                                                  'Car'
                                                              ? SvgPicture
                                                                  .asset(
                                                                  AppAssets
                                                                      .icons_car_side_svg,
                                                                  height: 14,
                                                                  color: AppColors
                                                                      .greyColor,
                                                                )
                                                              : currentPlaceOnSchedule
                                                                          .vehicle ==
                                                                      'Bus'
                                                                  ? SvgPicture
                                                                      .asset(
                                                                      AppAssets
                                                                          .icons_bus_svg,
                                                                      height:
                                                                          14,
                                                                      color: AppColors
                                                                          .greyColor,
                                                                    )
                                                                  : currentPlaceOnSchedule
                                                                              .vehicle ==
                                                                          'Boat'
                                                                      ? SvgPicture
                                                                          .asset(
                                                                          AppAssets
                                                                              .icons_sailboat_svg,
                                                                          height:
                                                                              14,
                                                                          color:
                                                                              AppColors.greyColor,
                                                                        )
                                                                      : SvgPicture
                                                                          .asset(
                                                                          AppAssets
                                                                              .icons_train_svg,
                                                                          height:
                                                                              14,
                                                                          color:
                                                                              AppColors.greyColor,
                                                                        ),
                                                  Gap.k8.width,
                                                  PSmallText(
                                                    'Come by ' +
                                                        currentPlaceOnSchedule
                                                            .vehicle
                                                            .toString(),
                                                    color: AppColors.greyColor,
                                                  ),
                                                ],
                                              )
                                            : SizedBox.shrink()
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Gap.kSection.height,
                              PText('Nearby Suggestion'),
                              Gap.k16.height,
                              NearbyPlaceSuggestion(
                                key: _childKey,
                                query: '',
                                location: Position(
                                    longitude:
                                        currentPlaceOnSchedule.longitude!,
                                    latitude: currentPlaceOnSchedule.latitude!,
                                    timestamp: null,
                                    accuracy: 0,
                                    altitude: 0,
                                    heading: 0,
                                    speed: 0,
                                    speedAccuracy: 0),
                              )
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
  }
}

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final TextEditingController searchController;
  final FocusNode focusNode;
  final int currentLocationIndex;
  final Slot schedule;
  final Position currentLocation;
  const SearchBar(
      {super.key,
      required this.scaffoldKey,
      required this.searchController,
      required this.focusNode,
      required this.currentLocationIndex,
      required this.schedule,
      required this.currentLocation});

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

    return SafeArea(
      child: Column(
        children: [
          SafeSpace(
            child: Container(
                height: 44,
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
                    // cubit.getNearbyPlace(widget.searchController.text);
                    showCupertinoModalBottomSheet(
                        context: context,
                        builder: (context) => widget.currentLocationIndex < 0
                            ? BlocProvider(
                                create: (context) => NearbyPlaceCubit(
                                    widget.currentLocation,
                                    widget.searchController.text),
                                child: BlocBuilder<NearbyPlaceCubit,
                                        NearbyPlaceState>(
                                    builder: (context, state) {
                                  if (state is LoadingNearbyPlaceState) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (state is LoadNearbyPlaceSuccessState) {
                                    return NearbyPlaceList(
                                      state: state,
                                    );
                                  }
                                  if (state is NoResultsNearbyPlaceState) {
                                    return Center(
                                      child: Column(
                                        children: [
                                          32.height,
                                          Image.asset(
                                            AppAssets.not_found_png,
                                            width: 200,
                                          ),
                                          const PText(
                                            "Couldn't find any places around here",
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return SizedBox.shrink();
                                }))
                            : BlocProvider(
                                create: (context) => NearbyScheduleCubit(
                                    query: widget.searchController.text,
                                    lat: widget.schedule.latitude,
                                    lng: widget.schedule.longitude),
                                child: BlocBuilder<NearbyScheduleCubit,
                                        NearbyScheduleState>(
                                    builder: (context, state) {
                                  if (state is LoadingNearbyScheduleState) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (state is LoadNearbyScheduleSuccessState) {
                                    return NearbyScheduleList(
                                      state: state,
                                    );
                                  }
                                  if (state is NoResultsNearbyScheduleState) {
                                    return Center(
                                      child: Column(
                                        children: [
                                          32.height,
                                          Image.asset(
                                            AppAssets.not_found_png,
                                            width: 200,
                                          ),
                                          const PText(
                                            "Couldn't find any places around here",
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return SizedBox.shrink();
                                })));
                    // _resetChildState();
                    // setState(() {
                    //   query = _searchController.text;
                    //   _resetChild = true;
                    // });
                  },
                )),
          ),
          Gap.k8.height,
          _category(context, widget.currentLocation)
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

  Widget _category(BuildContext context, Position currentLocation) {
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
              showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) => widget.currentLocationIndex < 0
                      ? BlocProvider(
                          create: (context) => NearbyPlaceCubit(
                              currentLocation, catNames[index]),
                          child:
                              BlocBuilder<NearbyPlaceCubit, NearbyPlaceState>(
                                  builder: (context, state) {
                            if (state is LoadingNearbyPlaceState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is LoadNearbyPlaceSuccessState) {
                              return NearbyPlaceList(
                                state: state,
                              );
                            }
                            if (state is NoResultsNearbyPlaceState) {
                              return Center(
                                child: Column(
                                  children: [
                                    32.height,
                                    Image.asset(
                                      AppAssets.not_found_png,
                                      width: 200,
                                    ),
                                    const PText(
                                      "Couldn't find any places around here",
                                    ),
                                  ],
                                ),
                              );
                            }
                            return SizedBox.shrink();
                          }))
                      : BlocProvider(
                          create: (context) => NearbyScheduleCubit(
                              query: catNames[index],
                              lat: widget.schedule.latitude,
                              lng: widget.schedule.longitude),
                          child: BlocBuilder<NearbyScheduleCubit,
                              NearbyScheduleState>(builder: (context, state) {
                            if (state is LoadingNearbyScheduleState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is LoadNearbyScheduleSuccessState) {
                              return NearbyScheduleList(
                                state: state,
                              );
                            }
                            if (state is NoResultsNearbyScheduleState) {
                              return Center(
                                child: Column(
                                  children: [
                                    32.height,
                                    Image.asset(
                                      AppAssets.not_found_png,
                                      width: 200,
                                    ),
                                    const PText(
                                      "Couldn't find any places around here",
                                    ),
                                  ],
                                ),
                              );
                            }
                            return SizedBox.shrink();
                          })));
            });
          }),
    );
  }
}
