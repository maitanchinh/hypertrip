import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:geolocator/geolocator.dart';
import 'package:room_finder_flutter/models/discovery/search_response.dart';
import 'package:room_finder_flutter/models/discovery/tip_response.dart';

import '../../models/discovery/nearby_response.dart';
import '../../models/discovery/place_details_response.dart';
import '../../models/discovery/place_photo_response.dart';
import '../../utils/QueryString.dart';
import '../../utils/network.dart';

class PlaceRepository {
  Future<NearbyPlacesResponse> getNearbyPlaces() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // return null;
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var url = Uri.parse('${queryString['nearbyPlace']!['uri']}' +
        position.latitude.toString() +
        '${queryString['nearbyPlace']![',']}' +
        position.longitude.toString());
    Map<String, String> header = Map<String, String>.from(
        queryString['nearbyPlace']!['header'] as Map<dynamic, dynamic>);
    var response = await http.get(url, headers: header);
    return NearbyPlacesResponse.fromJson(jsonDecode(response.body));
  }
}

class PlacePhotoRepository {
  Future<List<PlacesPhotoResponse>> getPlacePhoto(String id) async {
    var photoUrl = Uri.parse(
        '${queryString['placePhoto']!['uri']}${id}${queryString['placePhoto']!['photo']}');
    Map<String, String> header = Map<String, String>.from(
        queryString['placePhoto']!['header'] as Map<dynamic, dynamic>);
    var photoResponse =
        await NetworkUtility.fetchUrl(photoUrl, headers: header);
    // var photoResponse = await http.get(photoUrl, headers: header);
    List<PlacesPhotoResponse> parsePhotos(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<PlacesPhotoResponse>(
              (json) => PlacesPhotoResponse.fromJson(json))
          .toList();
    }

    return parsePhotos(photoResponse.toString());
  }
}

class GetPlaceDetail {
  Future<PlaceDetailsResponse> getPlaceDetails(String id) async {
    var url = Uri.parse('${queryString['placeDetails']}${id}');
    Map<String, String> header = Map<String, String>.from(
        queryString['placeDetails']!['header'] as Map<dynamic, dynamic>);
    var detailsResponse = await NetworkUtility.fetchUrl(url, headers: header);

    return PlaceDetailsResponse.fromJson(
        jsonDecode(detailsResponse.toString()));
  }
}

class SearchRepository {
  Future<SearchPlaceResponse> searchPlace(
    String query,
  ) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // return null;
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var url = Uri.parse('${queryString['searchPlace']!['uri']}${query}' +
        '${queryString['searchPlace']!['ll']}' +
        position.latitude.toString() +
        '${queryString['searchPlace']![',']}' +
        position.longitude.toString() +
        '${queryString['searchPlace']!['radius']}');
    Map<String, String> header = Map<String, String>.from(
        queryString['searchPlace']!['header'] as Map<dynamic, dynamic>);
    var response = await NetworkUtility.fetchUrl(url, headers: header);
    return SearchPlaceResponse.fromJson(jsonDecode(response.toString()));
  }
}

class TipRepository {
  Future<List<TipResponse>> tip(String placeId) async {
    var url = Uri.parse(
        '${queryString['tip']!['uri']}${placeId}${queryString['tip']!['tip']}${queryString['tip']!['sort']}');
    Map<String, String> header = Map<String, String>.from(
        queryString['tip']!['header'] as Map<dynamic, dynamic>);
    var response = await NetworkUtility.fetchUrl(url, headers: header);
    List<TipResponse> parseTips(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<TipResponse>((json) => TipResponse.fromJson(json))
          .toList();
    }

    print(parseTips(response.toString()).first.text);
    return parseTips(response.toString());
  }
}
