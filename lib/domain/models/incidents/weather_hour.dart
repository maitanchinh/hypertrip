import 'package:hypertrip/domain/models/incidents/weather_condition.dart';

class WeatherHour {
  int timeEpoch;
  String time;
  double tempC;
  double tempF;
  int isDay;
  WeatherCondition? condition;
  double windMph;
  double windKph;
  int windDegree;
  String windDir;
  double pressureMb;
  double pressureIn;
  double precipMm;
  double precipIn;
  int humidity;
  int cloud;
  double feelslikeC;
  double feelslikeF;
  double windchillC;
  double windchillF;
  double heatindexC;
  double heatindexF;
  double dewpointC;
  double dewpointF;
  int willItRain;
  int chanceOfRain;
  int willItSnow;
  int chanceOfSnow;
  double visKm;
  double visMiles;
  double gustMph;
  double gustKph;
  double uv;

  WeatherHour({
    this.timeEpoch = 0,
    this.time = '',
    this.tempC = 0.0,
    this.tempF = 0.0,
    this.isDay = 0,
    this.condition,
    this.windMph = 0.0,
    this.windKph = 0.0,
    this.windDegree = 0,
    this.windDir = '',
    this.pressureMb = 0.0,
    this.pressureIn = 0.0,
    this.precipMm = 0.0,
    this.precipIn = 0.0,
    this.humidity = 0,
    this.cloud = 0,
    this.feelslikeC = 0.0,
    this.feelslikeF = 0.0,
    this.windchillC = 0.0,
    this.windchillF = 0.0,
    this.heatindexC = 0.0,
    this.heatindexF = 0.0,
    this.dewpointC = 0.0,
    this.dewpointF = 0.0,
    this.willItRain = 0,
    this.chanceOfRain = 0,
    this.willItSnow = 0,
    this.chanceOfSnow = 0,
    this.visKm = 0.0,
    this.visMiles = 0.0,
    this.gustMph = 0.0,
    this.gustKph = 0.0,
    this.uv = 0.0,
  });

  factory WeatherHour.fromJson(Map<String, dynamic> json) {
    return WeatherHour(
      timeEpoch: json['time_epoch'] ?? 0,
      time: json['time'] ?? '',
      tempC: json['temp_c'] ?? 0.0,
      tempF: json['temp_f'] ?? 0.0,
      isDay: json['is_day'] ?? 0,
      condition: json['condition'] != null
          ? WeatherCondition.fromJson(json['condition'])
          : null,
      windMph: json['wind_mph'] ?? 0.0,
      windKph: json['wind_kph'] ?? 0.0,
      windDegree: json['wind_degree'] ?? 0,
      windDir: json['wind_dir'] ?? '',
      pressureMb: json['pressure_mb'] ?? 0.0,
      pressureIn: json['pressure_in'] ?? 0.0,
      precipMm: json['precip_mm'] ?? 0.0,
      precipIn: json['precip_in'] ?? 0.0,
      humidity: json['humidity'] ?? 0,
      cloud: json['cloud'] ?? 0,
      feelslikeC: json['feelslike_c'] ?? 0.0,
      feelslikeF: json['feelslike_f'] ?? 0.0,
      windchillC: json['windchill_c'] ?? 0.0,
      windchillF: json['windchill_f'] ?? 0.0,
      heatindexC: json['heatindex_c'] ?? 0.0,
      heatindexF: json['heatindex_f'] ?? 0.0,
      dewpointC: json['dewpoint_c'] ?? 0.0,
      dewpointF: json['dewpoint_f'] ?? 0.0,
      willItRain: json['will_it_rain'] ?? 0,
      chanceOfRain: json['chance_of_rain'] ?? 0,
      willItSnow: json['will_it_snow'] ?? 0,
      chanceOfSnow: json['chance_of_snow'] ?? 0,
      visKm: json['vis_km'] ?? 0.0,
      visMiles: json['vis_miles'] ?? 0.0,
      gustMph: json['gust_mph'] ?? 0.0,
      gustKph: json['gust_kph'] ?? 0.0,
      uv: json['uv'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'time_epoch': timeEpoch,
    'time': time,
    'temp_c': tempC,
    'temp_f': tempF,
    'is_day': isDay,
    'condition': condition?.toJson(),
    'wind_mph': windMph,
    'wind_kph': windKph,
    'wind_degree': windDegree,
    'wind_dir': windDir,
    'pressure_mb': pressureMb,
    'pressure_in': pressureIn,
    'precip_mm': precipMm,
    'precip_in': precipIn,
    'humidity': humidity,
    'cloud': cloud,
    'feelslike_c': feelslikeC,
    'feelslike_f': feelslikeF,
    'windchill_c': windchillC,
    'windchill_f': windchillF,
    'heatindex_c': heatindexC,
    'heatindex_f': heatindexF,
    'dewpoint_c': dewpointC,
    'dewpoint_f': dewpointF,
    'will_it_rain': willItRain,
    'chance_of_rain': chanceOfRain,
    'will_it_snow': willItSnow,
    'chance_of_snow': chanceOfSnow,
    'vis_km': visKm,
    'vis_miles': visMiles,
    'gust_mph': gustMph,
    'gust_kph': gustKph,
    'uv': uv,
  };
}