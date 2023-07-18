import 'package:hypertrip/domain/models/incidents/weather_forecast_day.dart';

class WeatherForecast {
  List<WeatherForecastDay> forecastDay;

  WeatherForecast({this.forecastDay = const []});

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonForecastDay = json['forecastday'];
    List<WeatherForecastDay> parsedForecastDay = jsonForecastDay
        .map((day) => WeatherForecastDay.fromJson(day))
        .toList();

    return WeatherForecast(forecastDay: parsedForecastDay);
  }

  Map<String, dynamic> toJson() => {
    'forecastday': forecastDay.map((day) => day.toJson()).toList(),
  };
}