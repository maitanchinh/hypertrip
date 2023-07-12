class WeatherLocation {
  /// Tên địa điểm
  String name;

  /// Tên khu vực hoặc tỉnh.
  String region;

  /// Tên quốc gia
  String country;

  /// Vĩ độ của địa điểm
  double lat;

  /// Kinh độ của địa điểm
  double lon;

  /// Mã xác định múi giờ
  String tzId;

  /// Thời gian địa phương (dạng epoch time)
  int localtimeEpoch;

  /// Thời gian địa phương (định dạng ngày/giờ)
  String localtime;

  WeatherLocation({
    this.name = '',
    this.region = '',
    this.country = '',
    this.lat = 0.0,
    this.lon = 0.0,
    this.tzId = '',
    this.localtimeEpoch = 0,
    this.localtime = '',
  });

  factory WeatherLocation.fromJson(Map<String, dynamic> json) {
    return WeatherLocation(
      name: json['name'] ?? '',
      region: json['region'] ?? '',
      country: json['country'] ?? '',
      lat: json['lat'] ?? 0.0,
      lon: json['lon'] ?? 0.0,
      tzId: json['tz_id'] ?? '',
      localtimeEpoch: json['localtime_epoch'] ?? 0,
      localtime: json['localtime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'region': region,
    'country': country,
    'lat': lat,
    'lon': lon,
    'tz_id': tzId,
    'localtime_epoch': localtimeEpoch,
    'localtime': localtime,
  };
}