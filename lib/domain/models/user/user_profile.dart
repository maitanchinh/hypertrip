import 'package:chatview/chatview.dart';

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
  String firstContactNumber;
  String secondContactNumber;
  String? address;

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
    this.firstContactNumber = '',
    this.secondContactNumber = '',
    this.address,
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
    String? firstContactNumber,
    String? secondContactNumber,
    String? address,
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
        firstContactNumber: firstContactNumber ?? this.firstContactNumber,
        secondContactNumber: secondContactNumber ?? this.secondContactNumber,
        address: address ?? this.address,
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
        firstContactNumber: json["firstContactNumber"] ?? '',
        secondContactNumber: json["secondContactNumber"] ?? '',
        address: json["address"],
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
        "firstContactNumber": firstContactNumber,
        "secondContactNumber": secondContactNumber,
        "address": address,
      };

  ChatUser toMember() {
    return ChatUser(id: id ?? '', name: displayName, profilePhoto: avatarUrl);
  }

  String get displayName => (firstName != null && firstName!.isNotEmpty)
      ? '$firstName ${(lastName ?? '')}'
      : lastName ?? '';
}
