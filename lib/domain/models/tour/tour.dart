import 'package:hypertrip/domain/models/schedule/slot.dart';

class Tour {
  List<Slot>? schedules;
  List<dynamic>? carousel;
  String? id;
  String? title;
  String? departure;
  String? destination;
  String? duration;
  String? description;
  dynamic policy;
  String? thumbnailUrl;
  int? maxOccupancy;
  String? type;
  String? status;

  Tour({
    this.schedules,
    this.carousel,
    this.id,
    this.title,
    this.departure,
    this.destination,
    this.duration,
    this.description,
    this.policy,
    this.thumbnailUrl,
    this.maxOccupancy,
    this.type,
    this.status,
  });

  Tour copyWith({
    List<Slot>? schedules,
    List<dynamic>? carousel,
    String? id,
    String? title,
    String? departure,
    String? destination,
    String? duration,
    String? description,
    dynamic policy,
    String? thumbnailUrl,
    int? maxOccupancy,
    String? type,
    String? status,
  }) =>
      Tour(
        schedules: schedules ?? this.schedules,
        carousel: carousel ?? this.carousel,
        id: id ?? this.id,
        title: title ?? this.title,
        departure: departure ?? this.departure,
        destination: destination ?? this.destination,
        duration: duration ?? this.duration,
        description: description ?? this.description,
        policy: policy ?? this.policy,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        maxOccupancy: maxOccupancy ?? this.maxOccupancy,
        type: type ?? this.type,
        status: status ?? this.status,
      );

  factory Tour.fromJson(Map<String, dynamic> json) => Tour(
        schedules: json["schedules"] == null
            ? []
            : List<Slot>.from(json["schedules"]!.map((x) => Slot.fromJson(x))),
        carousel: json["carousel"] == null
            ? []
            : List<dynamic>.from(json["carousel"]!.map((x) => x)),
        id: json["id"],
        title: json["title"],
        departure: json["departure"],
        destination: json["destination"],
        duration: json["duration"],
        description: json["description"],
        policy: json["policy"],
        thumbnailUrl: json["thumbnailUrl"],
        maxOccupancy: json["maxOccupancy"],
        type: json["type"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "schedules": schedules == null
            ? []
            : List<dynamic>.from(schedules!.map((x) => x.toJson())),
        "carousel":
            carousel == null ? [] : List<dynamic>.from(carousel!.map((x) => x)),
        "id": id,
        "title": title,
        "departure": departure,
        "destination": destination,
        "duration": duration,
        "description": description,
        "policy": policy,
        "thumbnailUrl": thumbnailUrl,
        "maxOccupancy": maxOccupancy,
        "type": type,
        "status": status,
      };
}
