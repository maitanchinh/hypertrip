class CustomActivity {
  String? id;
  String? tourGroupId;
  String? title;
  int? dayNo;
  String? note;
  DateTime? createdAt;

  CustomActivity({
    this.id,
    this.tourGroupId,
    this.title,
    this.dayNo,
    this.note,
    this.createdAt,
  });

  CustomActivity copyWith({
    String? id,
    String? tourGroupId,
    String? title,
    int? dayNo,
    String? note,
    DateTime? createdAt,
  }) =>
      CustomActivity(
        id: id ?? this.id,
        tourGroupId: tourGroupId ?? this.tourGroupId,
        title: title ?? this.title,
        dayNo: dayNo ?? this.dayNo,
        note: note ?? this.note,
        createdAt: createdAt ?? this.createdAt,
      );

  factory CustomActivity.fromJson(Map<String, dynamic> json) => CustomActivity(
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
