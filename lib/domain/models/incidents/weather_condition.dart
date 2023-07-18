class WeatherCondition {
  String text;
  String icon;
  int code;

  WeatherCondition({this.text = '', this.icon = '', this.code = 0});

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      text: json['text'] ?? '',
      icon: json['icon'] ?? '',
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'text': text,
    'icon': icon,
    'code': code,
  };
}