import 'package:hypertrip/domain/models/activity/activity.dart';

//* ActivityState
class ActivityState {
  String filterText = "";
  String filterType = "All";
}

class ActivityInProgressState extends ActivityState {}

class ActivitySuccessState extends ActivityState {
  final List<Activity> activities;
  ActivitySuccessState(this.activities);
}

class ActivityFailureState extends ActivityState {
  final String message;
  ActivityFailureState(this.message);
}

class ActivityTypeChangedState extends ActivityState {
  ActivityTypeChangedState(String type) {
    filterType = type;
  }
}
