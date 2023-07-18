import 'package:hypertrip/domain/models/incidents/earth_quakes_property.dart';

class EarthquakesFeature {
  String type;
  EarthquakesProperty? properties;
  String id;

  EarthquakesFeature({this.type = '', this.properties, this.id = ''});

  factory EarthquakesFeature.fromJson(Map<String, dynamic> json) {
    return EarthquakesFeature(
      type: json['type'] ?? '',
      properties: json['properties'] != null
          ? EarthquakesProperty.fromJson(json['properties'])
          : null,
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'properties': properties?.toJson(),
    'id': id,
  };
}