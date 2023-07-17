import 'package:hypertrip/domain/models/incidents/earth_quakes_features.dart';

class EarthquakesResponse {
  List<EarthquakesFeature> features;

  EarthquakesResponse({this.features = const []});

  factory EarthquakesResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonFeatures = json['features'];
    List<EarthquakesFeature> parsedFeatures = jsonFeatures
        .map((feature) => EarthquakesFeature.fromJson(feature))
        .toList();

    return EarthquakesResponse(features: parsedFeatures);
  }

  Map<String, dynamic> toJson() => {
    'features': features.map((feature) => feature.toJson()).toList(),
  };
}