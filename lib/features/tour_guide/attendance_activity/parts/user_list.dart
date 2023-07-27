import 'package:flutter/material.dart';
import 'package:hypertrip/domain/models/activity/firebase_attendance_model.dart';
import 'package:hypertrip/features/tour_guide/attendance_activity/parts/user_list_item.dart';
import 'package:nb_utils/nb_utils.dart';

class UserList extends StatefulWidget {
  final List<FirebaseAttendanceItem> data;
  const UserList({super.key, required this.data});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    data.sort((a, b) {
      if (a.lastUpdateAt == null) return 1;
      if (b.lastUpdateAt == null) return -1;
      return b.lastUpdateAt!.compareTo(a.lastUpdateAt!);
    });

    return Material(
      type: MaterialType.transparency,
      child: ListView.separated(
        itemCount: data.length,
        separatorBuilder: (context, index) => 10.height,
        itemBuilder: (context, index) {
          return UserListItem(data: data[index]);
        },
      ),
    );
  }
}
