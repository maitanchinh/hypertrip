import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hypertrip/domain/models/nearby/nearby_place.dart';
import 'package:hypertrip/domain/models/nearby/nearby_place_photo.dart';
import 'package:hypertrip/utils/message.dart';

import '../../utils/get_it.dart';
import '../models/nearby/nearby_place_tip.dart';

class FoursquareRepo {
  final Dio publishApiClient = getIt.get<Dio>(instanceName: 'publishApiClient');

  FoursquareRepo();

  Future<NearbyPlace?> getNearbyPlace(String query) async {
    try {
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
      var url =
          '/places/search?query=$query&ll=${position.latitude}%2C${position.longitude}&radius=5000&sort=DISTANCE&limit=50';
      var response = await publishApiClient.get(url);

      return NearbyPlace.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(msg_server_error);
    }
  }

  Future<List<NearbyPlacePhoto>> getPlacePhoto(String placeId) async {
    try {
      var url = '/places/$placeId/photos';
      var response = await publishApiClient.get(url);
      // print(response);
      // List<NearbyPlacePhoto> parsePhotos(String responseBody) {
      //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      //   return parsed
      //       .map<NearbyPlacePhoto >((json) => NearbyPlacePhoto.fromJson(json))
      //       .toList();
      // }
      return NearbyPlacePhoto.fromJsonList(response.data);

      // return parsePhotos(response.toString());
    } on DioException catch (e) {
      throw Exception(msg_server_error);
    }
  }

  Future<List<Tip>> tip(String placeId) async {
    try {
      var url = '/places/$placeId/tips';
      var response = await publishApiClient.get(url);
      List<Tip> parseTips(String responseBody) {
        final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
        return parsed.map<Tip>((json) => Tip.fromJson(json)).toList();
      }

      return parseTips(response.toString());
    } catch (e) {
      throw Exception(msg_server_error);
    }
  }
}
