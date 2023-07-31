import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hypertrip/domain/models/nearby/nearby_place.dart';
import 'package:hypertrip/utils/message.dart';

import '../../utils/get_it.dart';

class FoursquareRepo {
  final Dio publishApiClient = getIt.get<Dio>(instanceName: 'publishApiClient');

  FoursquareRepo();

  Future<NearbyPlace?> getNearbyPlace(String query, Position currentLocation) async {
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
          '/places/search?query=$query&ll=${currentLocation.latitude}%2C${currentLocation.longitude}&radius=5000&fields=fsq_id%2Ccategories%2Cdate_closed%2Cdistance%2Cemail%2Cfeatures%2Chours%2Clocation%2Cname%2Cphotos%2Crating%2Csocial_media%2Ctel%2Ctips%2Cwebsite%2Cgeocodes%2Cprice&sort=DISTANCE&limit=50';
      var response = await publishApiClient.get(url);

      return NearbyPlace.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(msg_server_error);
    }
  }

  Future<bool> isPermissionGeolocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationServiceEnabled) {
      LocationPermission permission = await Geolocator.checkPermission();
      return (permission != LocationPermission.denied) &&
          (permission != LocationPermission.deniedForever);
    }
    return false;
  }

  Future<bool> requestPermission() async {
    bool isPermission = true;
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        isPermission = false;
      }
      isPermission = true;
    } else if (permission == LocationPermission.deniedForever) isPermission = false;

    return isPermission;
  }

  Future<Position?> getCurrentLocation() async {
    try {
      // Kiểm tra quyền truy cập vị trí
      final permission = await isPermissionGeolocation();
      if (!permission) null;

      // Lấy vị trí hiện tại
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return position;
    } catch (e) {
      return null;
    }
  }
}
