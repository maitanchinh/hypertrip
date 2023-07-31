class FirebaseAttendanceData {
  String title;
  List<FirebaseAttendanceItem> items;
  FirebaseAttendanceData({required this.title, required this.items});
}

class FirebaseAttendanceItem {
  DateTime? attendanceAt;
  String? id;
  bool? present;
  String? reason;
  String? userId;
  String? avatarUrl;
  String? name;
  DateTime? lastUpdateAt;

  FirebaseAttendanceItem({
    this.attendanceAt,
    this.id,
    this.present,
    this.reason,
    this.userId,
    this.avatarUrl,
    this.name,
    this.lastUpdateAt,
  });

  FirebaseAttendanceItem copyWith({
    DateTime? attendanceAt,
    String? id,
    bool? present,
    String? reason,
    String? userId,
    String? avatarUrl,
    String? name,
    DateTime? lastUpdateAt,
  }) =>
      FirebaseAttendanceItem(
        attendanceAt: attendanceAt ?? this.attendanceAt,
        id: id ?? this.id,
        present: present ?? this.present,
        reason: reason ?? this.reason,
        userId: userId ?? this.userId,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        name: name ?? this.name,
        lastUpdateAt: lastUpdateAt ?? this.lastUpdateAt,
      );

  static List<FirebaseAttendanceItem> fromPayload(Object payload) {
    var rs = (payload as Map<Object?, Object?>).values.map((value) {
      var item = value as Map<Object?, Object?>;
      return FirebaseAttendanceItem(
        attendanceAt: DateTime.parse(item["AttendanceAt"] as String),
        id: item["Id"] as String,
        present: item["Present"] as bool,
        reason: item["Reason"] as String,
        userId: item["UserId"] as String,
        avatarUrl: item["AvatarUrl"] as String,
        name: item["Name"] as String,
        lastUpdateAt: DateTime.parse(item["LastUpdateAt"] as String),
      );
    }).toList();

    return rs;
  }
}
