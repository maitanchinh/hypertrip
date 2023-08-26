import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:hypertrip/domain/models/group/group.dart';
import 'package:hypertrip/domain/models/incidents/weather_response.dart';
import 'package:hypertrip/domain/models/schedule/slot.dart';
import 'package:hypertrip/domain/models/user/member.dart';
import 'package:hypertrip/features/public/warning_incident/interactor/warning_incident_bloc.dart';
import 'package:hypertrip/utils/page_states.dart';

class CurrentTourState extends Equatable {
  final List<Slot> schedule;
  final Group group;
  final List<Member> members;
  final Map<int, WeatherResponse> dataWeatherTour;
  final List<LocationTour> locationTour;
  final String message;
  final PageState status;

  const CurrentTourState({
    required this.group,
    required this.members,
    required this.schedule,
    this.dataWeatherTour = const {},
    this.locationTour = const [],
    this.message = '',
    this.status = PageState.success,
  });

  List<int> getDays() {
    var days = schedule.map((e) => e.dayNo).toSet().whereType<int>().toList();

    days.sort();

    return days;
  }

  Map<int?, List<Slot>> getScheduleByDay() {
    return schedule.groupListsBy((e) => e.dayNo);
  }

  CurrentTourState copyWith({
    Group? group,
    List<Member>? members,
    List<Slot>? schedule,
    Map<int, WeatherResponse>? dataWeatherTour,
    List<LocationTour>? locationTour,
    String? message,
    PageState? status,
  }) {
    return CurrentTourState(
      group: group ?? this.group,
      members: members ?? this.members,
      schedule: schedule ?? this.schedule,
      dataWeatherTour: dataWeatherTour ?? this.dataWeatherTour,
      locationTour: locationTour ?? this.locationTour,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props =>
      [group, members, schedule, dataWeatherTour, locationTour, message, status];
}

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
