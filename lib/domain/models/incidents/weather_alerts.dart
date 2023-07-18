import 'package:hypertrip/domain/models/incidents/weather_alert.dart';

class WeatherAlerts {
  List<WeatherAlert> alert;

  WeatherAlerts({this.alert = const []});

  factory WeatherAlerts.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonAlerts = json['alert'];
    List<WeatherAlert> parsedAlerts = jsonAlerts
        .map((alert) => WeatherAlert.fromJson(alert))
        .toList();

    return WeatherAlerts(alert: parsedAlerts);
  }

  Map<String, dynamic> toJson() => {
    'alert': alert.map((alert) => alert.toJson()).toList(),
  };
}