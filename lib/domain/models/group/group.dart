import 'package:hypertrip/domain/models/tour/trip.dart';

class Group {
  String id;
  DateTime? createdAt;
  String? groupName;
  String? tourGuideId;
  int? maxOccupancy;
  String? tripId;
  int? travelerCount;
  Trip? trip;

  Group({
    required this.id,
    this.createdAt,
    this.groupName,
    this.tourGuideId,
    this.maxOccupancy,
    this.tripId,
    this.travelerCount,
    this.trip,
  });

  Group copyWith({
    String? id,
    DateTime? createdAt,
    String? groupName,
    String? tourGuideId,
    int? maxOccupancy,
    String? tripId,
    int? travelerCount,
    Trip? trip,
  }) =>
      Group(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        groupName: groupName ?? this.groupName,
        tourGuideId: tourGuideId ?? this.tourGuideId,
        maxOccupancy: maxOccupancy ?? this.maxOccupancy,
        tripId: tripId ?? this.tripId,
        travelerCount: travelerCount ?? this.travelerCount,
        trip: trip ?? this.trip,
      );

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        groupName: json["groupName"],
        tourGuideId: json["tourGuideId"],
        maxOccupancy: json["maxOccupancy"],
        tripId: json["tripId"],
        travelerCount: json["travelerCount"],
        trip: json["trip"] == null ? null : Trip.fromJson(json["trip"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "groupName": groupName,
        "tourGuideId": tourGuideId,
        "maxOccupancy": maxOccupancy,
        "tripId": tripId,
        "travelerCount": travelerCount,
        "trip": trip?.toJson(),
      };
}
