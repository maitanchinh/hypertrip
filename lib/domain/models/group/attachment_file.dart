class AttachmentFile {
  String id;
  String contentType;
  String url;

  AttachmentFile({this.id = '', this.contentType = '', this.url = ''});

  AttachmentFile.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        contentType = json['contentType'] ?? '',
        url = json['url'] ?? '';

  Map<String, dynamic> toJson() => {
    'id': id,
    'contentType': contentType,
    'url': url,
  };

  AttachmentFile copyWith({
    String? id,
    String? contentType,
    String? url,
  }) {
    return AttachmentFile(
      id: id ?? this.id,
      contentType: contentType ?? this.contentType,
      url: url ?? this.url,
    );
  }
}