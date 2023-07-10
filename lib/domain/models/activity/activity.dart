class Activity {
  String? type;
  dynamic data;
  DateTime? createdAt;

  Activity({
    this.type,
    this.data,
    this.createdAt,
  });

  Activity copyWith({
    String? type,
    dynamic data,
    DateTime? createdAt,
  }) =>
      Activity(
        type: type ?? this.type,
        data: data ?? this.data,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        type: json["type"],
        data: json["data"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "data": data,
        "createdAt": createdAt?.toIso8601String(),
      };

  static List<Activity> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((json) => Activity.fromJson(json)).toList();
}
