class PlacesPhotoResponse {
  String? id;
  String? createdAt;
  String? prefix;
  String? suffix;
  int? width;
  int? height;

  PlacesPhotoResponse(
      {this.id,
      this.createdAt,
      this.prefix,
      this.suffix,
      this.width,
      this.height});

  PlacesPhotoResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    prefix = json['prefix'];
    suffix = json['suffix'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['prefix'] = this.prefix;
    data['suffix'] = this.suffix;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}
