class Slot {
  String? id;
  int? sequence;
  String? description;
  double? longitude;
  double? latitude;
  int? dayNo;
  String? vehicle;

  Slot({
    this.id,
    this.sequence,
    this.description,
    this.longitude,
    this.latitude,
    this.dayNo,
    this.vehicle,
  });

  Slot copyWith({
    String? id,
    int? sequence,
    String? description,
    double? longitude,
    double? latitude,
    int? dayNo,
    String? vehicle,
  }) =>
      Slot(
        id: id ?? this.id,
        sequence: sequence ?? this.sequence,
        description: description ?? this.description,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        dayNo: dayNo ?? this.dayNo,
        vehicle: vehicle ?? this.vehicle,
      );

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        id: json["id"],
        sequence: json["sequence"],
        description: json["description"],
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        dayNo: json["dayNo"],
        vehicle: json["vehicle"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sequence": sequence,
        "description": description,
        "longitude": longitude,
        "latitude": latitude,
        "dayNo": dayNo,
        "vehicle": vehicle,
      };

  static List<Slot> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((e) => Slot.fromJson(e)).toList();
}
