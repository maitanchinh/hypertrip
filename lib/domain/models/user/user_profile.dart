class UserProfile {
  String? id;
  String? phone;
  String? email;
  dynamic birthday;
  String? firstName;
  String? lastName;
  String? gender;
  String? role;
  String? status;
  String? avatarUrl;

  UserProfile({
    this.id,
    this.phone,
    this.email,
    this.birthday,
    this.firstName,
    this.lastName,
    this.gender,
    this.role,
    this.status,
    this.avatarUrl,
  });

  UserProfile copyWith({
    String? id,
    String? phone,
    String? email,
    dynamic birthday,
    String? firstName,
    String? lastName,
    String? gender,
    String? role,
    String? status,
    String? avatarUrl,
  }) =>
      UserProfile(
        id: id ?? this.id,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        birthday: birthday ?? this.birthday,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        gender: gender ?? this.gender,
        role: role ?? this.role,
        status: status ?? this.status,
        avatarUrl: avatarUrl ?? this.avatarUrl,
      );

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        phone: json["phone"],
        email: json["email"],
        birthday: json["birthday"],
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
        "birthday": birthday,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "role": role,
        "status": status,
        "avatarUrl": avatarUrl,
      };
}
