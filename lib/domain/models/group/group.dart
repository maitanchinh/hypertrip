import 'package:hypertrip/domain/models/tour/trip.dart';

class Group {
  String? id;
  DateTime? createdAt;
  int? totalDays;
  String? groupName;
  String? tourGuideId;
  String? tripId;
  int? travelerCount;
  String? currentScheduleId;
  String? status;
  Trip? trip;

  Group({
    this.id,
    this.createdAt,
    this.totalDays,
    this.groupName,
    this.tourGuideId,
    this.tripId,
    this.travelerCount,
    this.currentScheduleId,
    this.status,
    this.trip,
  });

  Group copyWith({
    String? id,
    DateTime? createdAt,
    int? totalDays,
    String? groupName,
    String? tourGuideId,
    String? tripId,
    int? travelerCount,
    String? currentScheduleId,
    String? status,
    Trip? trip,
  }) =>
      Group(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        totalDays: totalDays ?? this.totalDays,
        groupName: groupName ?? this.groupName,
        tourGuideId: tourGuideId ?? this.tourGuideId,
        tripId: tripId ?? this.tripId,
        travelerCount: travelerCount ?? this.travelerCount,
        currentScheduleId: currentScheduleId ?? this.currentScheduleId,
        status: status ?? this.status,
        trip: trip ?? this.trip,
      );

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        totalDays: json["totalDays"],
        groupName: json["groupName"],
        tourGuideId: json["tourGuideId"],
        tripId: json["tripId"],
        travelerCount: json["travelerCount"],
        currentScheduleId: json["currentScheduleId"],
        status: json["status"],
        trip: json["trip"] == null ? null : Trip.fromJson(json["trip"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "totalDays": totalDays,
        "groupName": groupName,
        "tourGuideId": tourGuideId,
        "tripId": tripId,
        "travelerCount": travelerCount,
        "currentScheduleId": currentScheduleId,
        "status": status,
        "trip": trip?.toJson(),
      };
}
