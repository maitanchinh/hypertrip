import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/widgets/button/action_button.dart';
import 'package:hypertrip/widgets/text/p_text.dart';
import 'package:nb_utils/nb_utils.dart';

class ShareLocationMap extends StatefulWidget {
  static const routeName = '/share-location-map';
  final String? userId;
  const ShareLocationMap({super.key, this.userId});

  @override
  State<ShareLocationMap> createState() => _ShareLocationMapState();
}

class _ShareLocationMapState extends State<ShareLocationMap> {
  
  late GoogleMapController _controller;
  bool _added = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: transparentColor,
        leading: ActionButton(
            icon: AppAssets.icons_angle_left_svg,
            onPressed: () {
              Navigator.pop(context);
            }).paddingLeft(16),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('location').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              if (_added) {
                map(snapshot);
              }

              if (snapshot.data!.docs
                  .any((element) => element.id == widget.userId)) {
                return GoogleMap(
                  markers: {
                    Marker(
                        markerId: const MarkerId('id'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueMagenta),
                        position: LatLng(
                            snapshot.data!.docs.singleWhere((element) =>
                                element.id == widget.userId)['lat'],
                            snapshot.data!.docs.singleWhere((element) =>
                                element.id == widget.userId)['lng']))
                  },
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                          snapshot.data!.docs.singleWhere(
                              (element) => element.id == widget.userId)['lat'],
                          snapshot.data!.docs.singleWhere(
                              (element) => element.id == widget.userId)['lng']),
                      zoom: 14),
                  onMapCreated: (GoogleMapController controller) async {
                    setState(() {
                      _controller = controller;
                      _added = true;
                    });
                  },
                );
              }
              return const Center(
                child: PText('Users no longer share their location directly'),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const SizedBox.shrink();
          }),
    );
  }

  Future<void> map(AsyncSnapshot<QuerySnapshot> snapshot) async {
    await _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                snapshot.data!.docs.singleWhere(
                    (element) => element.id == widget.userId)['lat'],
                snapshot.data!.docs.singleWhere(
                    (element) => element.id == widget.userId)['lng']),
            zoom: 14)));
  }
}
