class Member {
  String? id;
  String? phone;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? role;
  String? status;
  String? avatarUrl;

  Member({
    this.id,
    this.phone,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.role,
    this.status,
    this.avatarUrl,
  });

  Member copyWith({
    String? id,
    String? phone,
    String? email,
    String? firstName,
    String? lastName,
    String? gender,
    String? role,
    String? status,
    String? avatarUrl,
  }) =>
      Member(
        id: id ?? this.id,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        gender: gender ?? this.gender,
        role: role ?? this.role,
        status: status ?? this.status,
        avatarUrl: avatarUrl ?? this.avatarUrl,
      );

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        phone: json["phone"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        role: json["role"],
        status: json["status"],
        avatarUrl: json["avatarUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "role": role,
        "status": status,
        "avatarUrl": avatarUrl,
      };

  static List<Member> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => Member.fromJson(e)).toList();
  }
}
