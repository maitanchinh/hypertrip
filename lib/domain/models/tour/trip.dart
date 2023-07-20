import 'tour.dart';

class Trip {
  String? id;
  String? code;
  int? adultPrice;
  int? childrenPrice;
  int? infantPrice;
  DateTime? startTime;
  DateTime? endTime;
  String? tourId;
  Tour? tour;

  Trip({
    this.id,
    this.code,
    this.adultPrice,
    this.childrenPrice,
    this.infantPrice,
    this.startTime,
    this.endTime,
    this.tourId,
    this.tour,
  });

  Trip copyWith({
    String? id,
    String? code,
    int? adultPrice,
    int? childrenPrice,
    int? infantPrice,
    DateTime? startTime,
    DateTime? endTime,
    String? tourId,
    Tour? tour,
  }) =>
      Trip(
        id: id ?? this.id,
        code: code ?? this.code,
        adultPrice: adultPrice ?? this.adultPrice,
        childrenPrice: childrenPrice ?? this.childrenPrice,
        infantPrice: infantPrice ?? this.infantPrice,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        tourId: tourId ?? this.tourId,
        tour: tour ?? this.tour,
      );

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        id: json["id"],
        code: json["code"],
        adultPrice: json["adultPrice"],
        childrenPrice: json["childrenPrice"],
        infantPrice: json["infantPrice"],
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
        "adultPrice": adultPrice,
        "childrenPrice": childrenPrice,
        "infantPrice": infantPrice,
        "startTime": startTime?.toIso8601String(),
        "endTime": endTime?.toIso8601String(),
        "tourId": tourId,
        "tour": tour?.toJson(),
      };
}
