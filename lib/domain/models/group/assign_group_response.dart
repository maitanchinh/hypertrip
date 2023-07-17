import 'package:hypertrip/domain/models/tour/trip.dart';

class AssignGroupResponse {
  String id;
  DateTime? createdAt;
  String groupName;
  String tourGuideId;
  int maxOccupancy;
  String tripId;
  Trip? trip;

  AssignGroupResponse({
    this.id = '',
    this.createdAt,
    this.groupName = '',
    this.tourGuideId = '',
    this.maxOccupancy = 0,
    this.tripId = '',
    this.trip,
  });

  AssignGroupResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        createdAt = json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        groupName = json['groupName'] ?? '',
        tourGuideId = json['tourGuideId'] ?? '',
        maxOccupancy = json['maxOccupancy'] ?? 0,
        tripId = json['tripId'] ?? '',
        trip = json['trip'] != null
            ? Trip.fromJson(json['trip'])
            : null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt?.toIso8601String(),
    'groupName': groupName,
    'tourGuideId': tourGuideId,
    'maxOccupancy': maxOccupancy,
    'tripId': tripId,
    'trip': trip?.toJson(),
  };

  AssignGroupResponse copyWith({
    String? id,
    DateTime? createdAt,
    String? groupName,
    String? tourGuideId,
    int? maxOccupancy,
    String? tourVariantId,
    Trip? trip,
  }) {
    return AssignGroupResponse(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      groupName: groupName ?? this.groupName,
      tourGuideId: tourGuideId ?? this.tourGuideId,
      maxOccupancy: maxOccupancy ?? this.maxOccupancy,
      tripId: tourVariantId ?? this.tripId,
      trip: trip ?? this.trip,
    );
  }
}