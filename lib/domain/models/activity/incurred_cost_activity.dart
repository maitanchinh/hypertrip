class IncurredCostActivityModel {
  String? id;
  String? tourGroupId;
  String? imageId;
  double? cost;
  String? currency;
  String? title;
  int? dayNo;
  String? note;
  DateTime? createdAt;
  String? imageUrl;

  IncurredCostActivityModel({
    this.id,
    this.tourGroupId,
    this.imageId,
    this.cost,
    this.currency,
    this.title,
    this.dayNo,
    this.note,
    this.createdAt,
    this.imageUrl,
  });

  IncurredCostActivityModel copyWith({
    String? id,
    String? tourGroupId,
    String? imageId,
    double? cost,
    String? currency,
    String? title,
    int? dayNo,
    String? note,
    DateTime? createdAt,
    String? imageUrl,
  }) =>
      IncurredCostActivityModel(
        id: id ?? this.id,
        tourGroupId: tourGroupId ?? this.tourGroupId,
        imageId: imageId ?? this.imageId,
        cost: cost ?? this.cost,
        currency: currency ?? this.currency,
        title: title ?? this.title,
        dayNo: dayNo ?? this.dayNo,
        note: note ?? this.note,
        createdAt: createdAt ?? this.createdAt,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory IncurredCostActivityModel.fromJson(Map<String, dynamic> json) =>
      IncurredCostActivityModel(
        id: json["id"],
        tourGroupId: json["tourGroupId"],
        imageId: json["imageId"],
        cost: json["cost"],
        currency: json["currency"],
        title: json["title"],
        dayNo: json["dayNo"],
        note: json["note"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tourGroupId": tourGroupId,
        "imageId": imageId,
        "cost": cost,
        "currency": currency,
        "title": title,
        "dayNo": dayNo,
        "note": note,
        "createdAt": createdAt?.toIso8601String(),
        "imageUrl": imageUrl,
      };
}
