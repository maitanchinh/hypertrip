class UploadAttachmentResponse {
  String? id;
  String? contentType;
  String? url;

  UploadAttachmentResponse({
    this.id,
    this.contentType,
    this.url,
  });

  UploadAttachmentResponse copyWith({
    String? id,
    String? contentType,
    String? url,
  }) =>
      UploadAttachmentResponse(
        id: id ?? this.id,
        contentType: contentType ?? this.contentType,
        url: url ?? this.url,
      );

  factory UploadAttachmentResponse.fromJson(Map<String, dynamic> json) =>
      UploadAttachmentResponse(
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
