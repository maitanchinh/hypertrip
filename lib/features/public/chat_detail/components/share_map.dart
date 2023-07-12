import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hypertrip/features/public/chat_detail/interactor/chat_detail_bloc.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:nb_utils/nb_utils.dart';

class ShareMap extends StatefulWidget {
  final Function(Position position)? onSharePosition;

  const ShareMap({super.key, this.onSharePosition});

  @override
  State<ShareMap> createState() => _ShareMapState();
}

class _ShareMapState extends State<ShareMap> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};
  bool _initMarker = false;
  List<Marker> markerList = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDetailBloc, ChatDetailState>(
      builder: (context, state) {
        if (state.position != null) {
          init(context, state.position!);
        }
        return !_initMarker
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state.isPermissionGeolocation
                ? Stack(
                    children: [
                      GoogleMap(
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        markers: markerList.toSet(),
                        zoomControlsEnabled: true,
                        zoomGesturesEnabled: false,
                        rotateGesturesEnabled: false,
                        myLocationButtonEnabled: true,
                        compassEnabled: false,
                        mapToolbarEnabled: false,
                        buildingsEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: state.position != null
                              ? LatLng(state.position!.latitude, state.position!.longitude)
                              : const LatLng(10.762622, 106.660172), // Tọa độ ban đầu của bản đồ
                          zoom: 18, // Độ phóng ban đầu
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(Radius.circular(16))),
                          child: TextButton(
                            onPressed: () => widget.onSharePosition?.call(state.position!),
                            child: Text(
                              sendCurrentPosition,
                              style: boldTextStyle(size: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: GestureDetector(
                            onLongPress: () {
                              context.read<ChatDetailBloc>().add(const DragPanelEvent(true));
                            },
                            onLongPressEnd: (details) {
                              context.read<ChatDetailBloc>().add(const DragPanelEvent(false));
                            },
                            child: Container(
                              width: 80,
                              height: 10,
                              decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(Radius.circular(8))),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: GestureDetector(
                          onLongPress: () {
                            context.read<ChatDetailBloc>().add(const DragPanelEvent(true));
                          },
                          onLongPressEnd: (details) {
                            context.read<ChatDetailBloc>().add(const DragPanelEvent(false));
                          },
                          child: Container(
                            width: 80,
                            height: 50,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: TextButton(
                      onPressed: () {
                        context.read<ChatDetailBloc>().add(const RequestPermissionLocationEvent());
                      },
                      child: Text(requestPermissionGeo, style: boldTextStyle(size: 16)),
                    ),
                  );
      },
    );
  }

  void init(BuildContext context, Position position) async {
    if (_initMarker) return;

    ImageConfiguration imageConfiguration = ImageConfiguration(
        devicePixelRatio: MediaQuery.of(context).devicePixelRatio, size: const Size(21, 25));

    BitmapDescriptor bitmap = await BitmapDescriptor.fromAssetImage(
      imageConfiguration,
      AppAssets.ic_location_marker_png,
    );

    markerList = [];

    final marketId = MarkerId((0).toString());
    final marker = Marker(
      markerId: marketId,
      position: LatLng(position.latitude, position.longitude),
      icon: bitmap,
      onTap: () => _onSelectedPositionMarker(marketId),
    );
    markerList.add(marker);

    setState(() {
      _initMarker = true;
    });
  }

  _onSelectedPositionMarker(MarkerId markerId) async {
    // Get.find<SearchMapBloc>()
    //     .add(SearchMapEvent.onSelectedPositionMarker(int.tryParse(markerId.value) ?? 0));
  }
}
