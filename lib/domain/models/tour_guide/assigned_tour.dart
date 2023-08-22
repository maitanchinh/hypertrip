class AssignedTour {
  String? id;
  String? createdAt;
  String? groupName;
  int? groupNo;
  String? tourGuideId;
  String? tripId;
  int? travelerCount;
  String? currentScheduleId;
  String? status;
  Trip? trip;

  AssignedTour(
      {this.id,
      this.createdAt,
      this.groupName,
      this.groupNo,
      this.tourGuideId,
      this.tripId,
      this.travelerCount,
      this.currentScheduleId,
      this.status,
      this.trip});

  AssignedTour.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    groupName = json['groupName'];
    groupNo = json['groupNo'];
    tourGuideId = json['tourGuideId'];
    tripId = json['tripId'];
    travelerCount = json['travelerCount'];
    currentScheduleId = json['currentScheduleId'];
    status = json['status'];
    trip = json['trip'] != null ? new Trip.fromJson(json['trip']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['groupName'] = this.groupName;
    data['groupNo'] = this.groupNo;
    data['tourGuideId'] = this.tourGuideId;
    data['tripId'] = this.tripId;
    data['travelerCount'] = this.travelerCount;
    data['currentScheduleId'] = this.currentScheduleId;
    data['status'] = this.status;
    if (this.trip != null) {
      data['trip'] = this.trip!.toJson();
    }
    return data;
  }

  static List<AssignedTour> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((e) => AssignedTour.fromJson(e)).toList();
}

class Trip {
  String? id;
  String? code;
  String? startTime;
  String? endTime;
  String? tourId;
  Tour? tour;

  Trip(
      {this.id,
      this.code,
      this.startTime,
      this.endTime,
      this.tourId,
      this.tour});

  Trip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    tourId = json['tourId'];
    tour = json['tour'] != null ? new Tour.fromJson(json['tour']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['tourId'] = this.tourId;
    if (this.tour != null) {
      data['tour'] = this.tour!.toJson();
    }
    return data;
  }
}

class Tour {
  String? id;
  String? title;
  String? departure;
  String? destination;
  String? duration;
  String? description;
  Null? guide;
  String? thumbnailUrl;
  String? createdAt;
  String? type;

  Tour(
      {this.id,
      this.title,
      this.departure,
      this.destination,
      this.duration,
      this.description,
      this.guide,
      this.thumbnailUrl,
      this.createdAt,
      this.type});

  Tour.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    departure = json['departure'];
    destination = json['destination'];
    duration = json['duration'];
    description = json['description'];
    guide = json['guide'];
    thumbnailUrl = json['thumbnailUrl'];
    createdAt = json['createdAt'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['departure'] = this.departure;
    data['destination'] = this.destination;
    data['duration'] = this.duration;
    data['description'] = this.description;
    data['guide'] = this.guide;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['createdAt'] = this.createdAt;
    data['type'] = this.type;
    return data;
  }

  
}
