import 'package:flutter/material.dart';
import 'package:hypertrip/domain/enums/activity_type.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_assets.dart';

class ActivityTypeData {
  final ActivityType type;
  final String label;
  final String icon;
  final Color color;

  ActivityTypeData({
    required this.type,
    required this.label,
    required this.icon,
    required this.color,
  });
}

final List<ActivityTypeData> activitiesTypeData = [
  ActivityTypeData(
    type: ActivityType.All,
    label: "All",
    icon: AppAssets.icons_filter_svg,
    color: AppColors.textGreyColor,
  ),
  ActivityTypeData(
    type: ActivityType.Attendance,
    label: "Attendance",
    icon: AppAssets.icons_clipboard_user_svg,
    color: AppColors.primaryColor,
  ),
  ActivityTypeData(
    type: ActivityType.CheckIn,
    label: "Check-In",
    icon: AppAssets.icons_circle_check_svg,
    color: AppColors.purpleColor,
  ),
  ActivityTypeData(
    type: ActivityType.IncurredCost,
    label: "Incurred Costs",
    icon: AppAssets.icons_money_bill_svg,
    color: AppColors.yellowColor,
  ),
];
