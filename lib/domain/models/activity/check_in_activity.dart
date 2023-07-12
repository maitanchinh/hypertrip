class CheckInActivity {
  String? id;
  String? tourGroupId;
  String? title;
  int? dayNo;
  String? note;
  DateTime? createdAt;

  CheckInActivity({
    this.id,
    this.tourGroupId,
    this.title,
    this.dayNo,
    this.note,
    this.createdAt,
  });

  CheckInActivity copyWith({
    String? id,
    String? tourGroupId,
    String? title,
    int? dayNo,
    String? note,
    DateTime? createdAt,
  }) =>
      CheckInActivity(
        id: id ?? this.id,
        tourGroupId: tourGroupId ?? this.tourGroupId,
        title: title ?? this.title,
        dayNo: dayNo ?? this.dayNo,
        note: note ?? this.note,
        createdAt: createdAt ?? this.createdAt,
      );

  factory CheckInActivity.fromJson(Map<String, dynamic> json) =>
      CheckInActivity(
        id: json["id"],
        tourGroupId: json["tourGroupId"],
        title: json["title"],
        dayNo: json["dayNo"],
        note: json["note"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tourGroupId": tourGroupId,
        "title": title,
        "dayNo": dayNo,
        "note": note,
        "createdAt": createdAt?.toIso8601String(),
      };
}
