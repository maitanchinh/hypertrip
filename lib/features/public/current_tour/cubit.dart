import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:hypertrip/domain/models/group/group.dart';
import 'package:hypertrip/domain/models/incidents/weather_alerts.dart';
import 'package:hypertrip/domain/models/incidents/weather_current.dart';
import 'package:hypertrip/domain/models/incidents/weather_forecast.dart';
import 'package:hypertrip/domain/models/incidents/weather_location.dart';
import 'package:hypertrip/domain/models/incidents/weather_response.dart';
import 'package:hypertrip/domain/models/schedule/slot.dart';
import 'package:hypertrip/domain/repositories/group_repo.dart';
import 'package:hypertrip/domain/repositories/notification_repo.dart';
import 'package:hypertrip/domain/repositories/tour_repo.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/domain/repositories/warning_incident_repository.dart';
import 'package:hypertrip/features/public/warning_incident/interactor/warning_incident_bloc.dart';
import 'package:hypertrip/managers/firebase_messaging_manager.dart';
import 'package:hypertrip/utils/constant.dart';
import 'package:hypertrip/utils/get_it.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/utils/page_states.dart';
import 'package:nb_utils/nb_utils.dart';

import 'state.dart';

class CurrentTourCubit extends Cubit<CurrentTourState> {
  final GroupRepo _groupRepo = getIt<GroupRepo>();
  final TourRepo _tourRepo = getIt<TourRepo>();
  final NotificationRepo notificationRepo = getIt<NotificationRepo>();
  final UserRepo userRepo = getIt<UserRepo>();
  final FirebaseMessagingManager _firebaseMessagingManager = getIt<FirebaseMessagingManager>();
  final WarningIncidentRepository _warningIncidentRepository = getIt<WarningIncidentRepository>();

  CurrentTourCubit()
      : super(
          CurrentTourState(
            status: PageState.success,
            group: Group(),
            members: const [],
            schedule: const [],
          ),
        ) {}

  void init() {
    getCurrentTour();
    _registerFCMToken();
    _countNotification();
  }

  void getCurrentTour() async {
    try {
      var group = await _groupRepo.getCurrentGroup();
      if (group == null) {
        emit(state.copyWith(status: PageState.failure));
        return;
      }

      var members = await _groupRepo.getMembers(group.id);
      var schedule = await _tourRepo.getSchedule(group.trip?.tourId);

      emit(state.copyWith(
          group: group, members: members, schedule: schedule, status: PageState.success));

      _fetchAllLocationTour();
    } on Exception catch (_) {
      emit(state.copyWith(status: PageState.failure, message: msg_server_error));
    }
  }

  FutureOr<void> _fetchAllLocationTour() {
    final loadCurrentTourSuccessState = state;
    final Map<int, WeatherResponse> dataWeatherTour = {};

    loadCurrentTourSuccessState.schedule.sort((a, b) => a.dayNo!.compareTo(b.dayNo!));

    List<LocationTour> locationTour = loadCurrentTourSuccessState.schedule
        .map((e) => LocationTour(lat: e.latitude ?? 0.0, lng: e.longitude ?? 0.0))
        .toList();

    if (locationTour.isNotEmpty) {
      // Remove LocationTour objects with lat and lng equal to 0.0
      locationTour.removeWhere((tour) => tour.lat == 0.0 && tour.lng == 0.0);
      for (int i = 0; i < locationTour.length; i++) {
        dataWeatherTour[i] = WeatherResponse(
          location: WeatherLocation(),
          alerts: WeatherAlerts(),
          current: WeatherCurrent(),
          forecast: WeatherForecast(),
        );
      }

      emit(loadCurrentTourSuccessState.copyWith(
          dataWeatherTour: dataWeatherTour, locationTour: locationTour));

      // Find index weather
      // If lat,lng = 0 return index = 0

      final currentScheduleId = loadCurrentTourSuccessState.group.currentScheduleId;
      Slot? schedule = loadCurrentTourSuccessState.schedule
          .firstWhereOrNull((element) => element.id == currentScheduleId);

      int previousIndex = 0;
      if (schedule?.latitude == null || schedule?.longitude == null) {
        schedule = findSlotHaveLocation(loadCurrentTourSuccessState);
      }

      int index = locationTour.indexWhere(
          (element) => element.lat == schedule?.latitude && element.lng == schedule?.longitude);

      // If previous != 0 and currentIndex not found inside locationTour
      if (index != -1) {
        previousIndex = index;
      }
      fetchDataWeather(previousIndex);
    }
  }

  Slot findSlotHaveLocation(CurrentTourState state) {
    int index = -1;
    final indexCurrent =
        state.schedule.indexWhere((element) => element.id == state.group.currentScheduleId);

    int i = 1;

    while (index == -1) {
      final previousIndex = indexCurrent - i;
      if (previousIndex < 0) {
        index = 0;
        break;
      }
      final slot = state.schedule[previousIndex];
      if (slot.latitude != null && slot.longitude != null) {
        index = previousIndex;
      }
      i++;
    }

    return state.schedule[index];
  }

  FutureOr<Map<int, WeatherResponse>> fetchDataWeather(int index) async {
    final Map<int, WeatherResponse> dataWeatherTour = {};

    final loadCurrentTourSuccessState = state;
    try {
      final result = await _warningIncidentRepository.fetchDataWeather(
        lat: loadCurrentTourSuccessState.locationTour[index].lat,
        lng: loadCurrentTourSuccessState.locationTour[index].lng,
      );

      final updatedDataWeatherTour = loadCurrentTourSuccessState.dataWeatherTour.map((key, value) {
        // if (key == index) {
        return MapEntry(
            key,
            value.copyWith(
                forecast: result.forecast,
                current: result.current,
                alerts: result.alerts,
                location: result.location));
        // }
        return MapEntry(key, value);
      });

      emit(loadCurrentTourSuccessState.copyWith(dataWeatherTour: updatedDataWeatherTour));
    } catch (e) {
      print("ex ${e.toString()}");
    }
    return dataWeatherTour;
  }

  void refresh() {
    emit(state.copyWith(status: PageState.loading));
    getCurrentTour();
  }

  FutureOr<void> _countNotification() async {
    final result = await notificationRepo.getCountNotify();

    setValue(AppConstant.keyCountNotify, result);
  }

  void _registerFCMToken() async {
    final user = await userRepo.getProfile();
    _firebaseMessagingManager.registerTokenFCM(user.id ?? '');
  }

  FutureOr<void> onClickEndTour(String? id) async {
    final result = await _groupRepo.endCurrentTourGroup(id ?? '');
    if (result) {
      toast("End tour success");
      emit(state.copyWith(status: PageState.failure,group: Group()));
    } else {
      toast("Can't end tour, please contact Support!");
    }
  }
}

//Current Group
class CurrentGroupCubit extends Cubit<CurrentGroupState> {
  final GroupRepo _groupRepo = getIt<GroupRepo>();

  CurrentGroupCubit() : super(LoadingCurrentGroupState()) {
    getCurrentTour();
  }

  void getCurrentTour() async {
    try {
      var group = await _groupRepo.getCurrentGroup();
      if (group == null) {
        emit(LoadCurrentGroupNotFoundState());
        return;
      }

      emit(LoadCurrentGroupSuccessState(group: group));
    } on Exception catch (_) {
      emit(LoadCurrentGroupFailedState(msg: msg_server_error));
    }
  }

  void refresh() {
    emit(LoadingCurrentGroupState());
    getCurrentTour();
  }
}
