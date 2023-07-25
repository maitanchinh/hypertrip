import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:hypertrip/domain/models/incidents/earth_quakes_response.dart';
import 'package:hypertrip/domain/models/incidents/weather_alert.dart';
import 'package:hypertrip/domain/models/incidents/weather_alerts.dart';
import 'package:hypertrip/domain/models/incidents/weather_current.dart';
import 'package:hypertrip/domain/models/incidents/weather_forecast.dart';
import 'package:hypertrip/domain/models/incidents/weather_location.dart';
import 'package:hypertrip/domain/models/incidents/weather_response.dart';
import 'package:hypertrip/utils/message.dart';

class WarningIncidentRepository {
  String weatherKey = 'fba32bf22570466094285146232806';
  String weatherApi = 'https://api.weatherapi.com/v1/forecast.json';

  String earthQuakesApi = 'https://earthquake.usgs.gov/fdsnws/event/1/query';

  final Dio _apiClient;

  WarningIncidentRepository(this._apiClient);

  FutureOr<WeatherResponse> fetchDataWeather(
      {int days = 3, double lat = 10.762622, double lng = 106.660172}) async {
    final response = await http
        .get(Uri.parse('$weatherApi?key=$weatherKey&q=$lat,$lng&days=$days&aqi=no&alerts=yes'));

    if (response.statusCode == 200) {
      return response.body.isNotEmpty
          ? WeatherResponse.fromJson(jsonDecode(response.body))
          : WeatherResponse(
              location: WeatherLocation(),
              alerts: WeatherAlerts(),
              current: WeatherCurrent(),
              forecast: WeatherForecast(),
            );
    } else {
      print('Mã phản hồi: ${response.statusCode}');
      return WeatherResponse(
        location: WeatherLocation(),
        alerts: WeatherAlerts(),
        current: WeatherCurrent(),
        forecast: WeatherForecast(),
      );
    }
  }

  FutureOr<EarthquakesResponse> fetchDataEarthQuakes({
    String startTime = '2023-05-01',
    String endTime = '2023-05-02',
    int radius = 100,
    double lat = 37.7749,
    double lng = -122.4194,
  }) async {
    final response = await http.get(Uri.parse(
        '$earthQuakesApi?format=geojson&latitude=$lat&longitude=$lng&starttime=$startTime&endtime=$endTime&maxradiuskm=$radius'));

    if (response.statusCode == 200) {
      return response.body.isNotEmpty
          ? EarthquakesResponse.fromJson(jsonDecode(response.body))
          : EarthquakesResponse();
    } else {
      print('Mã phản hồi: ${response.statusCode}');
      return EarthquakesResponse();
    }
  }

  Future<List<WeatherAlert>> getAlertTrip(String tripId) async {
    try {
      var response = await _apiClient.get('/trips/$tripId/weather-alerts');

      return (response.data as List<dynamic>)
          .map((assignGroup) => WeatherAlert.fromJson(assignGroup))
          .toList();
    } on DioException catch (e) {
      throw Exception(msg_server_error);
    }
  }
}
