import 'package:collection/collection.dart';
import 'package:hypertrip/domain/models/group/group.dart';
import 'package:hypertrip/domain/models/schedule/slot.dart';
import 'package:hypertrip/domain/models/user/member.dart';

class CurrentTourState {}

class LoadingCurrentTourState extends CurrentTourState {}

class LoadCurrentTourFailedState extends CurrentTourState {
  final String message;

  LoadCurrentTourFailedState({required this.message});
}

class LoadCurrentTourSuccessState extends CurrentTourState {
  List<Slot> schedule;
  Group group;
  List<Member> members;

  LoadCurrentTourSuccessState({
    required this.group,
    required this.members,
    required this.schedule,
  });

  List<int> getDays() {
    var days = schedule.map((e) => e.dayNo).toSet().whereType<int>().toList();

    days.sort();

    return days;
  }

  Map<int?, List<Slot>> getScheduleByDay() {
    return schedule.groupListsBy((e) => e.dayNo);
  }

}

class LoadCurrentTourNotFoundState extends CurrentTourState {}

//Current Group
class CurrentGroupState {}

class LoadingCurrentGroupState extends CurrentGroupState {}

class LoadCurrentGroupFailedState extends CurrentGroupState {
  final String msg;
  LoadCurrentGroupFailedState({required this.msg});
}

class LoadCurrentGroupSuccessState extends CurrentGroupState {
  Group group;

  LoadCurrentGroupSuccessState({required this.group});
}

class LoadCurrentGroupNotFoundState extends CurrentGroupState {}
