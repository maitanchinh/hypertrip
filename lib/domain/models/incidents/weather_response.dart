import 'package:hypertrip/domain/models/incidents/weather_alerts.dart';
import 'package:hypertrip/domain/models/incidents/weather_current.dart';
import 'package:hypertrip/domain/models/incidents/weather_forecast.dart';
import 'package:hypertrip/domain/models/incidents/weather_location.dart';

class WeatherResponse {
  WeatherLocation location;
  WeatherCurrent current;
  WeatherForecast forecast;
  WeatherAlerts alerts;

  WeatherResponse({
    required this.location,
    required this.current,
    required this.forecast,
    required this.alerts,
  });

  WeatherResponse copyWith({
    WeatherLocation? location,
    WeatherCurrent? current,
    WeatherForecast? forecast,
    WeatherAlerts? alerts,
  }) {
    return WeatherResponse(
      location: location ?? this.location,
      current: current ?? this.current,
      forecast: forecast ?? this.forecast,
      alerts: alerts ?? this.alerts,
    );
  }

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      location: WeatherLocation.fromJson(json['location']),
      current: WeatherCurrent.fromJson(json['current']),
      forecast: WeatherForecast.fromJson(json['forecast']),
      alerts: WeatherAlerts.fromJson(json['alerts']),
    );
  }

  Map<String, dynamic> toJson() => {
    'location': location.toJson(),
    'current': current.toJson(),
    'forecast': forecast.toJson(),
    'alerts': alerts.toJson(),
  };
}