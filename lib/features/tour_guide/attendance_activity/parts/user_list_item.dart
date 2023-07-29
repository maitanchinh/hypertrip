import 'package:flutter/material.dart';
import 'package:hypertrip/domain/models/activity/firebase_attendance_model.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/widgets/image/image.dart';
import 'package:nb_utils/nb_utils.dart';

class UserListItem extends StatelessWidget {
  final FirebaseAttendanceItem data;

  const UserListItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: commonCachedNetworkImage(
        data.avatarUrl,
        width: 50,
        height: 50,
        radius: 50,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      contentPadding:
          const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 20),
      tileColor:
          data.present ?? false ? AppColors.greenColor : AppColors.grey2Color,
      selectedTileColor: Colors.green,
      title:
          Text(data.name.validate(), style: boldTextStyle(color: Colors.white)),
    );
  }
}
