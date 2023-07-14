import 'package:hypertrip/domain/models/activity/activity.dart';

//* ActivityState
class ActivityState {
  int totalDays = 0;
  List<Activity> activities = [];
  String filterText = "";
  String filterType = "All";
  int selectedDay = 0;
  List<Activity> filteredActivities = [];

  ActivityState copyWith({
    int? totalDays,
    List<Activity>? activities,
    String? filterText,
    String? filterType,
    int? selectedDay,
    List<Activity>? filteredActivities,
  }) {
    return ActivityState()
      ..totalDays = totalDays ?? this.totalDays
      ..activities = activities ?? this.activities
      ..filterText = filterText ?? this.filterText
      ..filterType = filterType ?? this.filterType
      ..selectedDay = selectedDay ?? this.selectedDay
      ..filteredActivities = filteredActivities ?? this.filteredActivities;
  }
}

class ActivityInProgressState extends ActivityState {}

class ActivitySuccessState extends ActivityState {
  ActivitySuccessState({
    required List<Activity> activities,
    required List<Activity> filteredActivities,
    required int totalDays,
  }) {
    this.activities = activities;
    this.filteredActivities = filteredActivities;
    this.totalDays = totalDays;
  }
}

class ActivityFailureState extends ActivityState {
  final String message;
  ActivityFailureState(this.message);
}

class ActivityFilterChangedState extends ActivityState {
  ActivityFilterChangedState(ActivityState state) {
    totalDays = state.totalDays;
    filterText = state.filterText;
    filterType = state.filterType;
    selectedDay = state.selectedDay;
    activities = state.activities;
    filteredActivities = state.filteredActivities;
  }
}
