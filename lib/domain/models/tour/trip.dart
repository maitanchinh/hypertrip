import 'tour.dart';

class Trip {
  String? id;
  String? code;
  DateTime? startTime;
  DateTime? endTime;
  String? tourId;
  Tour? tour;

  Trip({
    this.id,
    this.code,
    this.startTime,
    this.endTime,
    this.tourId,
    this.tour,
  });

  Trip copyWith({
    String? id,
    String? code,
    DateTime? startTime,
    DateTime? endTime,
    String? tourId,
    Tour? tour,
  }) =>
      Trip(
        id: id ?? this.id,
        code: code ?? this.code,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        tourId: tourId ?? this.tourId,
        tour: tour ?? this.tour,
      );

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        id: json["id"],
        code: json["code"],
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        tourId: json["tourId"],
        tour: json["tour"] == null ? null : Tour.fromJson(json["tour"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "startTime": startTime?.toIso8601String(),
        "endTime": endTime?.toIso8601String(),
        "tourId": tourId,
        "tour": tour?.toJson(),
      };
}
