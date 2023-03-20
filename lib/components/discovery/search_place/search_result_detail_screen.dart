import 'package:flutter/material.dart' as Material;
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/components/RFCongratulatedDialog.dart';
import 'package:room_finder_flutter/models/discovery/place_photo_response.dart';
import 'package:room_finder_flutter/models/discovery/search_response.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

import 'search_result_detail_component.dart';

class SearchPlaceDetailsScreen extends StatefulWidget {
  final Results place;
  final List<PlacesPhotoResponse> photos;

  SearchPlaceDetailsScreen({required this.place, required this.photos});

  @override
  _SearchPlaceDetailsScreenState createState() =>
      _SearchPlaceDetailsScreenState();
}

class _SearchPlaceDetailsScreenState extends State<SearchPlaceDetailsScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppButton(
        color: rf_primaryColor,
        elevation: 0,
        child: Text('Book Now', style: boldTextStyle(color: white)),
        width: context.width(),
        onTap: () {
          showInDialog(context, barrierDismissible: true, builder: (context) {
            return RFCongratulatedDialog();
          });
        },
      ).paddingSymmetric(horizontal: 16, vertical: 24),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: Material.Icon(Icons.arrow_back_ios_new,
                    color: white, size: 18),
                onPressed: () {
                  finish(context);
                },
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
              ),
              backgroundColor: rf_primaryColor,
              pinned: true,
              elevation: 2,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                titlePadding: EdgeInsets.all(10),
                centerTitle: true,
                background: Stack(
                  children: [
                    rfCommonCachedNetworkImage(
                      '${widget.photos[0].prefix}original${widget.photos[0].suffix}',
                      fit: BoxFit.cover,
                      width: context.width(),
                      height: 350,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.place.categories!.first.name.validate(),
                              style: boldTextStyle(color: white, size: 18)),
                          8.height,
                          // Row(
                          //   children: [
                          //     Text("${widget.hotelData!.price.validate()} ",
                          //         style: boldTextStyle(color: white)),
                          //     Text(widget.hotelData!.rentDuration.validate(),
                          //         style: secondaryTextStyle(color: white)),
                          //   ],
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchPlaceDetailComponent(
                  place: widget.place, photos: widget.photos),
            ],
          ),
        ),
      ),
    );
  }
}
