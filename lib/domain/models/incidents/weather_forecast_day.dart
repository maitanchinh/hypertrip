import 'package:hypertrip/domain/models/incidents/weather_hour.dart';

class WeatherForecastDay {
  List<WeatherHour> hours;

  WeatherForecastDay({this.hours = const []});

  factory WeatherForecastDay.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonHours = json['hour'];
    List<WeatherHour> parsedHours = jsonHours
        .map((hour) => WeatherHour.fromJson(hour))
        .toList();
    return WeatherForecastDay(hours: parsedHours);
  }

  Map<String, dynamic> toJson() => {
    'hour': hours.map((hour) => hour.toJson()).toList(),
  };
}