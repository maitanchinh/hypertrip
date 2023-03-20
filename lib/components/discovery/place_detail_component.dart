import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/components/discovery/map_dialog_component.dart';
import 'package:room_finder_flutter/models/discovery/nearby_response.dart';
import 'package:room_finder_flutter/models/discovery/place_photo_response.dart';
import 'package:room_finder_flutter/models/discovery/tip_response.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:flutter/material.dart' as Material;

import '../../data/repositories/repositories.dart';

class PlaceDetailComponent extends StatefulWidget {
  final Results place;
  final List<PlacesPhotoResponse> photos;

  PlaceDetailComponent({required this.place, required this.photos});

  @override
  State<PlaceDetailComponent> createState() => _PlaceDetailComponentState();
}

class _PlaceDetailComponentState extends State<PlaceDetailComponent> {
  late Future<List<TipResponse>> tips;
  @override
  void initState() {
    super.initState();
    getTips();
    _controller = PageController(viewportFraction: 0.8);
  }

  void getTips() {
    tips = TipRepository().tip(widget.place.fsqId.toString());
  }

  late final PageController _controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Row(
              children: [
                // rfCommonCachedNetworkImage(rf_user,
                //         width: 60, height: 60, fit: BoxFit.cover)
                //     .cornerRadiusWithClipRRect(30),
                // 16.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${widget.place.name}', style: boldTextStyle()),
                    // 4.height,
                    // Text('Landlord', style: secondaryTextStyle()),
                  ],
                ).expand(),

                // 8.width,
                // AppButton(
                //   onTap: () {
                //     launchMail("demo@gmail.com");
                //   },
                //   color: rf_primaryColor,
                //   width: 15,
                //   height: 15,
                //   elevation: 0,
                //   child: rf_message.iconImage(iconColor: white, size: 14),
                // ),
              ],
            ),
            24.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material.Icon(Icons.location_on, color: rf_primaryColor)
                    .paddingOnly(top: 2),
                16.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        widget.place.distance! > 100
                            ? '${(widget.place.distance! / 1000).toStringAsFixed(2)} km away'
                            : 'Nearby',
                        style: boldTextStyle()),
                    8.height,
                    Text('${widget.place.location!.address}',
                        style: primaryTextStyle()),
                    // 8.height,
                    // Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     Text('0 Applied',
                    //             style: boldTextStyle(
                    //                 color: appStore.isDarkModeOn
                    //                     ? white
                    //                     : rf_textColor))
                    //         .flexible(),
                    //     4.width,
                    //     Container(
                    //         height: 16, width: 1, color: context.iconColor),
                    //     4.width,
                    //     Text('19 Views',
                    //             style: boldTextStyle(
                    //                 color: appStore.isDarkModeOn
                    //                     ? white
                    //                     : rf_textColor))
                    //         .flexible(),
                    //   ],
                    // )
                  ],
                ).expand(),
                16.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Row(
                    //   children: [
                    //     Container(
                    //       padding: EdgeInsets.all(4),
                    //       decoration: boxDecorationWithRoundedCorners(
                    //           backgroundColor: hotelData!.color!,
                    //           boxShape: BoxShape.circle),
                    //     ),
                    //     6.width,
                    //     Text(hotelData!.address.validate(),
                    //         style: secondaryTextStyle()),
                    //   ],
                    // ),
                    // 8.height,
                    // Text(
                    //   'Property Owned By: Alok',
                    //   style: primaryTextStyle(),
                    //   maxLines: 2,
                    //   overflow: TextOverflow.ellipsis,
                    // ).paddingOnly(left: 2),
                    // 8.height,
                    // Text(
                    //   'View on Google Maps',
                    //   style: primaryTextStyle(
                    //       color: appStore.isDarkModeOn ? white : rf_textColor,
                    //       decoration: TextDecoration.underline),
                    // ).paddingOnly(left: 2),
                    AppButton(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => (MapDialog(
                                  lat: widget.place.geocodes!.main!.latitude,
                                  lng: widget.place.geocodes!.main!.longitude,
                                )));
                        setState(() {});
                      },
                      color: rf_primaryColor,
                      width: 5,
                      height: 5,
                      elevation: 0,
                      child: Material.Icon(
                        Icons.map,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ).expand()
              ],
            ),
          ],
        ).paddingAll(24),
        HorizontalList(
          padding: EdgeInsets.only(right: 24, left: 24),
          wrapAlignment: WrapAlignment.spaceEvenly,
          itemCount: widget.photos.length,
          itemBuilder: (_, int index) => Stack(
            alignment: Alignment.center,
            children: [
              rfCommonCachedNetworkImage(
                  '${widget.photos[index].prefix}100x100${widget.photos[index].suffix}',
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover),
              // Container(
              //   height: 70,
              //   width: 70,
              //   decoration: boxDecorationWithRoundedCorners(
              //     borderRadius: BorderRadius.circular(8),
              //     backgroundColor: black.withOpacity(0.5),
              //   ),
              // ),
              // Text('+ 5',
              //         style: boldTextStyle(color: white, size: 20),
              //         textAlign: TextAlign.center)
              //     .visible(index == 3),
            ],
          ),
        ),
        Text('Tips', style: boldTextStyle())
            .paddingOnly(left: 24, top: 24, bottom: 8),
        8.height,
        FutureBuilder<List<TipResponse>>(
            future: tips,
            builder: (BuildContext context,
                AsyncSnapshot<List<TipResponse>> snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(
                  height: context.height() * 0.5,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else {
                final tips = snapshot.data!;
                return SizedBox(
                  height: 150,
                  width: context.width(),
                  child: PageView.builder(
                      controller: _controller,
                      itemCount: tips.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Stack(alignment: Alignment.center, children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${DateFormat('dd/MM/yyyy').format(DateTime.parse(tips[index].createdAt.toString()))}'),
                                  8.height,
                                  Text('${tips[index].text}',
                                      style: primaryTextStyle()),
                                ],
                              ),
                              width: context.width(),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ]),
                        );
                      }),
                );
              }
            }),
      ],
    );
  }
}
