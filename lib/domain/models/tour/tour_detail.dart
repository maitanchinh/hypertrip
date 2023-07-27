import 'package:hypertrip/domain/models/schedule/slot.dart';
import 'package:hypertrip/domain/models/tour/carousel.dart';

class TourDetail {
  List<Slot>? schedules;
  List<Carousel>? carousel;
  String? id;
  String? title;
  String? departure;
  String? destination;
  String? duration;
  String? description;
  dynamic policy;
  String? thumbnailUrl;
  String? type;

  TourDetail({
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
    this.type,
  });

  TourDetail copyWith({
    List<Slot>? schedules,
    List<Carousel>? carousel,
    String? id,
    String? title,
    String? departure,
    String? destination,
    String? duration,
    String? description,
    dynamic policy,
    String? thumbnailUrl,
    String? type,
  }) =>
      TourDetail(
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
        type: type ?? this.type,
      );

  factory TourDetail.fromJson(Map<String, dynamic> json) => TourDetail(
        schedules: json["schedules"] == null
            ? []
            : List<Slot>.from(json["schedules"]!.map((x) => Slot.fromJson(x))),
        carousel: json["carousel"] == null
            ? []
            : List<Carousel>.from(
                json["carousel"]!.map((x) => Carousel.fromJson(x))),
        id: json["id"],
        title: json["title"],
        departure: json["departure"],
        destination: json["destination"],
        duration: json["duration"],
        description: json["description"],
        policy: json["policy"],
        thumbnailUrl: json["thumbnailUrl"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "schedules": schedules == null
            ? []
            : List<dynamic>.from(schedules!.map((x) => x.toJson())),
        "carousel": carousel == null
            ? []
            : List<dynamic>.from(carousel!.map((x) => x.toJson())),
        "id": id,
        "title": title,
        "departure": departure,
        "destination": destination,
        "duration": duration,
        "description": description,
        "policy": policy,
        "thumbnailUrl": thumbnailUrl,
        "type": type,
      };
}
