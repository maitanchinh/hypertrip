class Tip {
  String? id;
  String? createdAt;
  String? text;

  Tip({this.id, this.createdAt, this.text});

  Tip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['text'] = this.text;
    return data;
  }
}
