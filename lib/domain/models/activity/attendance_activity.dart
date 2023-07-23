class AttendanceActivityModel {
  String? id;
  String? tourGroupId;
  String? title;
  int? dayNo;
  DateTime? createdAt;
  String? note;

  AttendanceActivityModel({
    this.id,
    this.tourGroupId,
    this.title,
    this.dayNo,
    this.createdAt,
    this.note,
  });

  AttendanceActivityModel copyWith({
    String? id,
    String? tourGroupId,
    String? title,
    int? dayNo,
    DateTime? createdAt,
    String? note,
  }) =>
      AttendanceActivityModel(
        id: id ?? this.id,
        tourGroupId: tourGroupId ?? this.tourGroupId,
        title: title ?? this.title,
        dayNo: dayNo ?? this.dayNo,
        createdAt: createdAt ?? this.createdAt,
        note: note ?? this.note,
      );

  factory AttendanceActivityModel.fromJson(Map<String, dynamic> json) =>
      AttendanceActivityModel(
        id: json["id"],
        tourGroupId: json["tourGroupId"],
        title: json["title"],
        dayNo: json["dayNo"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tourGroupId": tourGroupId,
        "title": title,
        "dayNo": dayNo,
        "createdAt": createdAt?.toIso8601String(),
        "note": note,
      };
}
