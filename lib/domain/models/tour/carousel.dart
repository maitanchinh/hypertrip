class Carousel {
  String? id;
  String? contentType;
  String? url;

  Carousel({
    this.id,
    this.contentType,
    this.url,
  });

  Carousel copyWith({
    String? id,
    String? contentType,
    String? url,
  }) =>
      Carousel(
        id: id ?? this.id,
        contentType: contentType ?? this.contentType,
        url: url ?? this.url,
      );

  factory Carousel.fromJson(Map<String, dynamic> json) => Carousel(
        id: json["id"],
        contentType: json["contentType"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contentType": contentType,
        "url": url,
      };
}
