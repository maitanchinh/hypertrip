class AttendanceActivity {
  String? id;
  String? tourGroupId;
  String? title;
  int? dayNo;
  DateTime? createdAt;
  String? note;

  AttendanceActivity({
    this.id,
    this.tourGroupId,
    this.title,
    this.dayNo,
    this.createdAt,
    this.note,
  });

  AttendanceActivity copyWith({
    String? id,
    String? tourGroupId,
    String? title,
    int? dayNo,
    DateTime? createdAt,
    String? note,
  }) =>
      AttendanceActivity(
        id: id ?? this.id,
        tourGroupId: tourGroupId ?? this.tourGroupId,
        title: title ?? this.title,
        dayNo: dayNo ?? this.dayNo,
        createdAt: createdAt ?? this.createdAt,
        note: note ?? this.note,
      );

  factory AttendanceActivity.fromJson(Map<String, dynamic> json) =>
      AttendanceActivity(
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
