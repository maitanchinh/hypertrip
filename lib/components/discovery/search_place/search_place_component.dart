import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/discovery/place_photo_response.dart';
import 'package:room_finder_flutter/models/discovery/search_response.dart';
import '../../../data/repositories/repositories.dart';
import 'search_results_list_component.dart';

class SearchPlaceComponent extends StatefulWidget {
  String query;
  SearchPlaceComponent({super.key, required this.query});

  @override
  State<SearchPlaceComponent> createState() => _SearchPlacesComponentState();
}

class _SearchPlacesComponentState extends State<SearchPlaceComponent> {
  late Future<SearchPlaceResponse> searchPlaceResponse;
  PlacesPhotoResponse placePhoto = PlacesPhotoResponse();
  double lat = 0.0, lon = 0.0;

  @override
  void initState() {
    super.initState();
    searchPlaceResponse = SearchRepository().searchPlace(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SearchPlaceResponse>(
        future: searchPlaceResponse,
        builder: (BuildContext context,
            AsyncSnapshot<SearchPlaceResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: context.height() * 0.5,
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final nearbyPlaces = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16),
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: nearbyPlaces.results!.length,
              itemBuilder: (BuildContext context, int index) {
                try {
                  if (nearbyPlaces.results![index].categories != null &&
                      !nearbyPlaces.results![index].categories!.isEmpty) {
                    Results results = nearbyPlaces.results![index];

                    return SearchPlaceListComponent(
                      place: results,
                      photoIndex: 0,
                    );
                  }
                } catch (e) {
                  print(e.toString());
                }
                return null;
              },
            );
          } else {
            return SizedBox.shrink();
          }
        });
    // Column(
    //   children: [
    //     if (nearbyPlacesResponse.results != null)
    //       for (int i = 0; i < nearbyPlacesResponse.results!.length; i++)
    //         NearbyPlaceWidget(nearbyPlacesResponse.results![i])
    //   ],
    // );
  }
}
