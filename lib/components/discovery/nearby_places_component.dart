import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_finder_flutter/components/discovery/place_list_component.dart';
import 'package:room_finder_flutter/models/discovery/nearby_response.dart';
import 'package:room_finder_flutter/models/discovery/place_photo_response.dart';
import '../../blocs/nearby/nearby_bloc.dart';
import '../../blocs/nearby/nearby_state.dart';

class NearbyPlacesComponent extends StatefulWidget {
  String category;
  NearbyPlacesComponent({super.key, required this.category});

  @override
  State<NearbyPlacesComponent> createState() => _NearbyPlacesComponentState();
}

class _NearbyPlacesComponentState extends State<NearbyPlacesComponent> {
  late Future<NearbyPlacesResponse> nearbyPlacesResponse;
  late Future<NearbyPlacesResponse> nearbyPlacesByCategory;
  Results results = Results();
  PlacesPhotoResponse placePhoto = PlacesPhotoResponse();
  double lat = 0.0, lon = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceBloc, PlaceState>(builder: (context, state) {
      if (state is PlaceLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is PlaceLoadedState) {
        NearbyPlacesResponse places = state.places;
        print('${places}');
        return Center(
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16),
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: places.results!.length,
            itemBuilder: (BuildContext context, int index) {
              try {
                if (widget.category == 'All') {
                  if (places.results![index].categories != null &&
                      !places.results![index].categories!.isEmpty) {
                    Results results = places.results![index];

                    return PlaceListComponent(
                      place: results,
                      photoIndex: 0,
                    );
                  }
                } else {
                  // for (var i = 0;
                  //     i < places.results![index].categories!.length;) {
                  //   if (places.results![index].categories![i].name!
                  //       .contains(widget.category)) {
                  //     Results results = places.results![index];
                  //     return PlaceListComponent(
                  //       place: results,
                  //       photoIndex: 0,
                  //     );
                  //   } else {
                  //     return SizedBox.shrink();
                  //   }
                  // }
                  if (places.results![index].categories!
                      .where(
                          (element) => element.name!.contains(widget.category))
                      .toList()
                      .isNotEmpty) {
                    Results results = places.results![index];
                    return PlaceListComponent(
                      place: results,
                      photoIndex: 0,
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }
              } catch (e) {
                print(e.toString());
              }
              return null;
            },
          ),
        );
      } else {
        return SizedBox.shrink();
      }
    });
  }
  // Column(
  //   children: [
  //     if (nearbyPlacesResponse.results != null)
  //       for (int i = 0; i < nearbyPlacesResponse.results!.length; i++)
  //         NearbyPlaceWidget(nearbyPlacesResponse.results![i])
  //   ],
  // );
}
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<NearbyPlacesResponse>(
//         future: nearbyPlacesResponse,
//         builder: (BuildContext context,
//             AsyncSnapshot<NearbyPlacesResponse> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return SizedBox(
//               height: context.height() * 0.5,
//               child: Center(child: CircularProgressIndicator()),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else if (snapshot.hasData) {
//             final nearbyPlaces = snapshot.data!;
//             return ListView.builder(
//               shrinkWrap: true,
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               physics: NeverScrollableScrollPhysics(),
//               scrollDirection: Axis.vertical,
//               itemCount: nearbyPlaces.results!.length,
//               itemBuilder: (BuildContext context, int index) {
//                 try {
//                   if (widget.category == 'All') {
//                     if (nearbyPlaces.results![index].categories != null &&
//                         !nearbyPlaces.results![index].categories!.isEmpty) {
//                       Results results = nearbyPlaces.results![index];

//                       return PlaceListComponent(
//                         placeNearby: results,
//                         photoIndex: 0,
//                       );
//                     }
//                   } else {
//                     for (var i = 0;
//                         i < nearbyPlaces.results![index].categories!.length;) {
//                       if (nearbyPlaces.results![index].categories![i].name!
//                           .contains(widget.category)) {
//                         Results results = nearbyPlaces.results![index];
//                         return PlaceListComponent(
//                           placeNearby: results,
//                           photoIndex: 0,
//                         );
//                       } else {
//                         return SizedBox.shrink();
//                       }
//                     }
//                   }
//                 } catch (e) {
//                   print(e.toString());
//                 }
//                 return null;
//               },
//             );
//           } else {
//             return SizedBox.shrink();
//           }
//         });
//     // Column(
//     //   children: [
//     //     if (nearbyPlacesResponse.results != null)
//     //       for (int i = 0; i < nearbyPlacesResponse.results!.length; i++)
//     //         NearbyPlaceWidget(nearbyPlacesResponse.results![i])
//     //   ],
//     // );
//   }
// }
