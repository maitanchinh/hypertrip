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
    return (payload as List<Object?>)
        .map((e) => e as Map<Object?, Object?>)
        .map((e) => FirebaseAttendanceItem(
              id: e["Id"]?.toString(),
              present: e["Present"] == true,
              attendanceAt: e["AttendanceAt"] != null
                  ? DateTime.parse(e["AttendanceAt"].toString())
                  : null,
              reason: e["Reason"]?.toString(),
              userId: e["UserId"]?.toString(),
              avatarUrl: e["AvatarUrl"]?.toString(),
              name: e["Name"]?.toString(),
              lastUpdateAt: e["LastUpdateAt"] != null
                  ? DateTime.parse(e["LastUpdateAt"].toString())
                  : null,
            ))
        .toList();
  }
}
