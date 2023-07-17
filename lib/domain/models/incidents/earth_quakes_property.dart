class EarthquakesProperty {
  double mag;

  EarthquakesProperty({this.mag = 0.0});

  factory EarthquakesProperty.fromJson(Map<String, dynamic> json) {
    return EarthquakesProperty(
      mag: json['mag'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'mag': mag,
  };
}