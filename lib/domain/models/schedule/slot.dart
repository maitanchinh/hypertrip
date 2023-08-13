class Slot {
  String? id;
  String? title;
  int? sequence;
  String? description;
  double? longitude;
  double? latitude;
  int? dayNo;
  String? vehicle;
  String? imageUrl;

  Slot({
    this.id,
    this.title,
    this.imageUrl,
    this.sequence,
    this.description,
    this.longitude,
    this.latitude,
    this.dayNo,
    this.vehicle,
  });

  Slot copyWith({
    String? id,
    String? title,
    int? sequence,
    String? description,
    double? longitude,
    double? latitude,
    int? dayNo,
    String? vehicle,
    String? imageUrl
  }) =>
      Slot(
        id: id ?? this.id,
        title: title ?? this.title,
        sequence: sequence ?? this.sequence,
        description: description ?? this.description,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        dayNo: dayNo ?? this.dayNo,
        vehicle: vehicle ?? this.vehicle,
        imageUrl: imageUrl ?? this.imageUrl
      );

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        id: json["id"],
        title: json["title"],
        sequence: json["sequence"],
        description: json["description"],
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        dayNo: json["dayNo"],
        vehicle: json["vehicle"],
        imageUrl: json["imageUrl"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "sequence": sequence,
        "description": description,
        "longitude": longitude,
        "latitude": latitude,
        "dayNo": dayNo,
        "vehicle": vehicle,
        "imageUrl": imageUrl
      };

  static List<Slot> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((e) => Slot.fromJson(e)).toList();
}

