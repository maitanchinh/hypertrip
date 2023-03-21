import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as Material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../blocs/nearby/nearby_bloc.dart';
import '../../blocs/nearby/nearby_event.dart';
import '../../blocs/nearby/nearby_state.dart';
import '../../components/discovery/map_dialog_component.dart';
import '../../components/discovery/nearby_places_component.dart';
import '../../components/discovery/search_place/search_place_component.dart';
import '../../data/repositories/repositories.dart';
import '../../models/discovery/nearby_response.dart';
import '../../utils/RFColors.dart';
import '../../utils/RFWidget.dart';

class MapFragment extends StatefulWidget {
  const MapFragment({super.key});

  @override
  State<MapFragment> createState() => _MapFragmentState();
}

class _MapFragmentState extends State<MapFragment> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  TextEditingController place = TextEditingController();

  FocusNode placeFocusNode = FocusNode();

  String dropdownValue = 'All';

  late LatLng latLngPosition = LatLng(0, 0);

  bool isSearch = false;

  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return null;
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latLngPosition = LatLng(position.latitude, position.longitude);
    });

    // Move camera to the current location
    mapController
        .animateCamera(CameraUpdate.newLatLngZoom(latLngPosition, 2.0));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return RepositoryProvider(
        create: (context) => PlaceRepository(),
        child: BlocProvider(
            create: (context) =>
                PlaceBloc(RepositoryProvider.of<PlaceRepository>(context))
                  ..add(LoadPlaceEvent()),
            child: Scaffold(
                body: RFCommonAppComponent(
                  scroll: true,
                  // title: RFAppName,
                  mainWidgetHeight: screenHeight * 0.2,
                  subWidgetHeight: screenHeight * 0.1,
                  cardWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Text('Tìm Kiếm', style: boldTextStyle(size: 18)),
                      // 16.height,
                      AppTextField(
                        controller: place,
                        focus: placeFocusNode,
                        textFieldType: TextFieldType.NAME,
                        decoration: rfInputDecoration(
                          lableText: "Bạn muốn tìm...",
                          showLableText: true,
                          showPreFixIcon: true,
                          prefixIcon: Material.Icon(Icons.search,
                              color: rf_primaryColor, size: 16),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                      ),
                      16.height,
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              color: rf_primaryColor,
                              child: Text('Tìm',
                                  style: boldTextStyle(color: white)),
                              elevation: 0,
                              onTap: searchQuery != ''
                                  ? () {
                                      setState(() {
                                        isSearch = true;
                                      });
                                    }
                                  : () {},
                            ),
                          ),
                          16.width,
                          AppButton(
                            color: rf_primaryColor,
                            child: Material.Icon(
                              Icons.near_me,
                              color: white,
                            ),
                            elevation: 0,
                            width: 30,
                            onTap: () {
                              setState(() {
                                isSearch = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  subWidget: Column(
                    children: [
                      !isSearch
                          ? Container(
                              width: context.width(),
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text('Gần bạn',
                                          style: boldTextStyle())),
                                  DropdownButton<String>(
                                    value: dropdownValue,
                                    style: primaryTextStyle(),
                                    underline: Container(),
                                    elevation: 10,
                                    icon: Material.Icon(Icons.filter_alt),
                                    items: <String>[
                                      'All',
                                      'Restaurant',
                                      'Store',
                                      'Coffee',
                                      'Market',
                                      'Hospital',
                                      'Residential',
                                      'Office',
                                      'Lookout'
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          textAlign: TextAlign.end,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        dropdownValue = value!;
                                      });
                                      print(dropdownValue);
                                    },
                                  )
                                ],
                              ),
                            )
                          : Container(
                              width: context.width(),
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text('Search results',
                                          style: boldTextStyle())),
                                ],
                              ),
                            ),
                      isSearch && searchQuery != ''
                          ? SearchPlaceComponent(query: searchQuery)
                          : NearbyPlacesComponent(
                              key: ValueKey(dropdownValue),
                              category: dropdownValue,
                            ),
                    ],
                  ),
                ),
                floatingActionButton: !isSearch
                    ? BlocBuilder<PlaceBloc, PlaceState>(
                        builder: (context, state) {
                        if (state is PlaceLoadedState) {
                          NearbyPlacesResponse places = state.places;

                          return FloatingActionButton(
                            backgroundColor: rf_primaryColor,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) => MapDialog(
                                        category: dropdownValue,
                                        places: places,
                                        lat: latLngPosition.latitude,
                                        lng: latLngPosition.longitude,
                                        nearby: true,
                                      ));
                              setState(() {});
                            },
                            child: Material.Icon(
                              Icons.map,
                              color: Colors.white,
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      })
                    : null)));
  }
}
