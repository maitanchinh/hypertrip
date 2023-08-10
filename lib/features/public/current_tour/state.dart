import 'package:collection/collection.dart';
import 'package:hypertrip/domain/models/group/group.dart';
import 'package:hypertrip/domain/models/incidents/weather_response.dart';
import 'package:hypertrip/domain/models/schedule/slot.dart';
import 'package:hypertrip/domain/models/user/member.dart';
import 'package:hypertrip/features/public/warning_incident/interactor/warning_incident_bloc.dart';

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
  final Map<int, WeatherResponse> dataWeatherTour;
  final List<LocationTour> locationTour;

  LoadCurrentTourSuccessState({
    required this.group,
    required this.members,
    required this.schedule,
    this.dataWeatherTour = const {},
    this.locationTour = const [],
  });

  List<int> getDays() {
    var days = schedule.map((e) => e.dayNo).toSet().whereType<int>().toList();

    days.sort();

    return days;
  }

  Map<int?, List<Slot>> getScheduleByDay() {
    return schedule.groupListsBy((e) => e.dayNo);
  }

  LoadCurrentTourSuccessState copyWith({
    Group? group,
    List<Member>? members,
    List<Slot>? schedule,
    Map<int, WeatherResponse>? dataWeatherTour,
    List<LocationTour>? locationTour,
  }) {
    return LoadCurrentTourSuccessState(
      group: group ?? this.group,
      members: members ?? this.members,
      schedule: schedule ?? this.schedule,
      dataWeatherTour: dataWeatherTour ?? this.dataWeatherTour,
      locationTour: locationTour ?? this.locationTour,
    );
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
