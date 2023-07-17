import 'package:hypertrip/domain/models/incidents/weather_condition.dart';

class WeatherCurrent {
  /// Thời gian cập nhật dữ liệu hiện tại, được đưa ra dưới dạng epoch time
  int lastUpdatedEpoch;

  /// Thời gian cập nhật dữ liệu hiện tại, được đưa ra dưới dạng ngày và giờ (theo định dạng YYYY-MM-DD HH:mm).
  String lastUpdated;

  /// Nhiệt độ hiện tại theo đơn vị Celsius.
  double tempC;

  /// Nhiệt độ hiện tại theo đơn vị Fahrenheit.
  double tempF;

  /// Chỉ ra liệu hiện tại là ban ngày hay ban đêm (1: ban ngày, 0: ban đêm).
  int isDay;

  /// Chứa thông tin về tình trạng thời tiết hiện tại
  WeatherCondition? condition;

  /// Tốc độ gió hiện tại theo đơn vị mph.
  double windMph;

  /// Tốc độ gió hiện tại theo đơn vị kph.
  double windKph;

  /// Hướng gió hiện tại trong độ (0-360).
  int windDegree;

  /// Hướng gió hiện tại dưới dạng văn bản (ví dụ: "SSW").
  String windDir;

  /// Áp suất không khí hiện tại theo đơn vị millibar.
  double pressureMb;

  /// Áp suất không khí hiện tại theo đơn vị inch
  double pressureIn;

  /// Lượng mưa tích lũy trong 1 giờ qua theo đơn vị milimét
  double precipMm;

  /// Lượng mưa tích lũy trong 1 giờ qua theo đơn vị inch
  double precipIn;

  /// Độ ẩm hiện tại theo phần trăm.
  int humidity;

  ///  Mây che phủ hiện tại theo phần trăm.
  int cloud;

  /// Nhiệt độ cảm nhận được hiện tại theo đơn vị Celsius.
  double feelslikeC;

  /// Nhiệt độ cảm nhận được hiện tại theo đơn vị Fahrenheit.
  double feelslikeF;

  /// Tầm nhìn hiện tại theo đơn vị kilômét
  double visKm;

  /// Tầm nhìn hiện tại theo đơn vị dặm
  double visMiles;

  /// Chỉ số tia tử ngoại hiện tại.
  double uv;

  /// Tốc độ gió giật hiện tại theo đơn vị mph
  double gustMph;

  /// Tốc độ gió giật hiện tại theo đơn vị kph
  double gustKph;

  WeatherCurrent({
    this.lastUpdatedEpoch = 0,
    this.lastUpdated = '',
    this.tempC = 0.0,
    this.tempF = 0.0,
    this.isDay = 1,
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
    this.visKm = 0.0,
    this.visMiles = 0.0,
    this.uv = 0.0,
    this.gustMph = 0.0,
    this.gustKph = 0.0,
  });

  factory WeatherCurrent.fromJson(Map<String, dynamic> json) {
    return WeatherCurrent(
      lastUpdatedEpoch: json['last_updated_epoch'] ?? 0,
      lastUpdated: json['last_updated'] ?? '',
      tempC: json['temp_c'] ?? 0.0,
      tempF: json['temp_f'] ?? 0.0,
      isDay: json['is_day'] ?? 1,
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
      visKm: json['vis_km'] ?? 0.0,
      visMiles: json['vis_miles'] ?? 0.0,
      uv: json['uv'] ?? 0.0,
      gustMph: json['gust_mph'] ?? 0.0,
      gustKph: json['gust_kph'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'last_updated_epoch': lastUpdatedEpoch,
    'last_updated': lastUpdated,
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
    'vis_km': visKm,
    'vis_miles': visMiles,
    'uv': uv,
    'gust_mph': gustMph,
    'gust_kph': gustKph,
  };
}