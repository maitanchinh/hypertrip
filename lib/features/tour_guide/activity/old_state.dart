import 'package:hypertrip/domain/enums/activity_type.dart';
import 'package:hypertrip/domain/models/activity/activity.dart';

//* ActivityState
class ActivityState {
  int totalDays = 0;
  List<Activity> activities = [];
  String filterText = "";
  ActivityType filterType = ActivityType.All;
  int selectedDay = 0;
  List<Activity> filteredActivities = [];
  String? tourGroupId;

  ActivityState copyWith({
    int? totalDays,
    List<Activity>? activities,
    String? filterText,
    ActivityType? filterType,
    int? selectedDay,
    List<Activity>? filteredActivities,
    String? tourGroupId,
  }) {
    return ActivityState()
      ..totalDays = totalDays ?? this.totalDays
      ..activities = activities ?? this.activities
      ..filterText = filterText ?? this.filterText
      ..filterType = filterType ?? this.filterType
      ..selectedDay = selectedDay ?? this.selectedDay
      ..filteredActivities = filteredActivities ?? this.filteredActivities
      ..tourGroupId = tourGroupId ?? this.tourGroupId;
  }
}

class ActivityInProgressState extends ActivityState {}

class ActivitySuccessState extends ActivityState {
  ActivitySuccessState(ActivityState state) {
    totalDays = state.totalDays;
    filterText = state.filterText;
    filterType = state.filterType;
    selectedDay = state.selectedDay;
    activities = state.activities;
    filteredActivities = state.filteredActivities;
    tourGroupId = state.tourGroupId;
  }
}

class ActivityFailureState extends ActivityState {
  final String message;
  ActivityFailureState(this.message);
}

// class ActivityFilterChangedState extends ActivityState {
//   ActivityFilterChangedState(ActivityState state) {
//     totalDays = state.totalDays;
//     filterText = state.filterText;
//     filterType = state.filterType;
//     selectedDay = state.selectedDay;
//     activities = state.activities;
//     filteredActivities = state.filteredActivities;
//   }
// }
