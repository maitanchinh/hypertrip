class Tour {
  String? id;
  String? title;
  String? departure;
  String? destination;
  String? duration;
  String? description;
  dynamic policy;
  String? thumbnailUrl;
  String? type;

  Tour({
    this.id,
    this.title,
    this.departure,
    this.destination,
    this.duration,
    this.description,
    this.policy,
    this.thumbnailUrl,
    this.type,
  });

  Tour copyWith({
    String? id,
    String? title,
    String? departure,
    String? destination,
    String? duration,
    String? description,
    dynamic policy,
    String? thumbnailUrl,
    String? type,
  }) =>
      Tour(
        id: id ?? this.id,
        title: title ?? this.title,
        departure: departure ?? this.departure,
        destination: destination ?? this.destination,
        duration: duration ?? this.duration,
        description: description ?? this.description,
        policy: policy ?? this.policy,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        type: type ?? this.type,
      );

  factory Tour.fromJson(Map<String, dynamic> json) => Tour(
        id: json["id"],
        title: json["title"],
        departure: json["departure"],
        destination: json["destination"],
        duration: json["duration"],
        description: json["description"],
        policy: json["policy"],
        thumbnailUrl: json["thumbnailUrl"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "departure": departure,
        "destination": destination,
        "duration": duration,
        "description": description,
        "policy": policy,
        "thumbnailUrl": thumbnailUrl,
        "type": type,
      };
}
