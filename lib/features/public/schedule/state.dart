import 'package:collection/collection.dart';
import 'package:hypertrip/domain/models/group/group.dart';
import 'package:hypertrip/domain/models/schedule/slot.dart';
import 'package:hypertrip/domain/models/user/member.dart';

import '../../../domain/models/nearby/nearby_place.dart';

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


// Nearby Place
class NearbyPlaceState {}

class LoadingNearbyPlaceState extends NearbyPlaceState {}

class NoResultsNearbyPlaceState extends NearbyPlaceState {}

class LoadNearbyPlaceFailedState extends NearbyPlaceState {
  final String message;
  LoadNearbyPlaceFailedState({required this.message});
}

class LoadNearbyPlaceSuccessState extends NearbyPlaceState {
  final NearbyPlace? nearbyPlace;

  LoadNearbyPlaceSuccessState({required this.nearbyPlace});
}
