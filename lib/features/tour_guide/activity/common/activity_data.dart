import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hypertrip/domain/enums/activity_type.dart';

class ActivityTypeData {
  final ActivityType type;
  final String label;
  final IconData icon;

  ActivityTypeData({
    required this.type,
    required this.label,
    required this.icon,
  });
}

final List<ActivityTypeData> activitiesTypeData = [
  ActivityTypeData(
      type: ActivityType.All, label: "All", icon: Icons.filter_list),
  ActivityTypeData(
      type: ActivityType.Attendance,
      label: "Attendance",
      icon: CupertinoIcons.person_crop_circle_badge_checkmark),
  ActivityTypeData(
      type: ActivityType.CheckIn,
      label: "Check-In",
      icon: CupertinoIcons.check_mark_circled),
];
