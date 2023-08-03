import 'package:hypertrip/domain/enums/activity_type.dart';
import 'package:hypertrip/utils/app_assets.dart';

class ActivityTypeData {
  final ActivityType type;
  final String label;
  final String icon;

  ActivityTypeData({
    required this.type,
    required this.label,
    required this.icon,
  });
}

final List<ActivityTypeData> activitiesTypeData = [
  ActivityTypeData(
      type: ActivityType.All, label: "All", icon: AppAssets.icons_filter_svg),
  ActivityTypeData(
      type: ActivityType.Attendance,
      label: "Attendance",
      icon: AppAssets.icons_clipboard_user_svg),
  ActivityTypeData(
      type: ActivityType.CheckIn,
      label: "Check-In",
      icon: AppAssets.icons_circle_check_svg),
  ActivityTypeData(
      type: ActivityType.IncurredCosts,
      label: "Incurred Costs",
      icon: AppAssets.icons_money_bill_svg),
];
