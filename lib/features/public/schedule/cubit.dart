import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hypertrip/domain/repositories/group_repo.dart';
import 'package:hypertrip/domain/repositories/notification_repo.dart';
import 'package:hypertrip/domain/repositories/tour_repo.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/managers/firebase_messaging_manager.dart';
import 'package:hypertrip/utils/constant.dart';
import 'package:hypertrip/utils/get_it.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../domain/repositories/foursquare_repo.dart';
import 'state.dart';

class CurrentTourCubit extends Cubit<CurrentTourState> {
  final GroupRepo _groupRepo = getIt<GroupRepo>();
  final TourRepo _tourRepo = getIt<TourRepo>();
  final NotificationRepo notificationRepo = getIt<NotificationRepo>();
  final UserRepo userRepo = getIt<UserRepo>();
  final FirebaseMessagingManager _firebaseMessagingManager =
      getIt<FirebaseMessagingManager>();

  CurrentTourCubit() : super(LoadingCurrentTourState()) {
    getCurrentTour();
    _registerFCMToken();
    _countNotification();
  }

  void getCurrentTour() async {
    try {
      var group = await _groupRepo.getCurrentGroup();
      if (group == null) {
        emit(LoadCurrentTourNotFoundState());
        return;
      }

      var members = await _groupRepo.getMembers(group.id);
      var schedule = await _tourRepo.getSchedule(group.trip?.tourId);

      emit(LoadCurrentTourSuccessState(
          group: group, members: members, schedule: schedule));
    } on Exception catch (_) {
      emit(LoadCurrentTourFailedState(message: msg_server_error));
    }
  }

  void refresh() {
    emit(LoadingCurrentTourState());
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
}

final FoursquareRepo _foursquareRepo = getIt<FoursquareRepo>();

//Nearby Place
class NearbyPlaceCubit extends Cubit<NearbyPlaceState> {
  final Position currentLocation;
  final String query;

  NearbyPlaceCubit(this.currentLocation, this.query)
      : super(NearbyPlaceState()) {
    getNearbyPlace(query);
  }

  Future<void> getNearbyPlace(String query) async {
    try {
      var place = await _foursquareRepo.getNearbyPlace(
          query, currentLocation);
      if (place!.results!.isEmpty) {
        emit(NoResultsNearbyPlaceState());
      } else {
        emit(LoadNearbyPlaceSuccessState(nearbyPlace: place));
      }
    } on Exception catch (e) {
      emit(LoadNearbyPlaceFailedState(message: e.toString()));
    }
  }

  void refresh() {
    emit(LoadingNearbyPlaceState());
    getNearbyPlace('');
  }
}

//Nearby Schedule
class NearbyScheduleCubit extends Cubit<NearbyScheduleState> {
  final String query;
  final double? lat;
  final double? lng;

  NearbyScheduleCubit( {required this.query, this.lat, this.lng})
      : super(NearbyScheduleState()) {
    getNearbyPlace(query);
  }

  Future<void> getNearbyPlace(String query) async {
    try {
      emit(LoadingNearbyScheduleState());
      var place = await _foursquareRepo.getNearbyPlace(
          query, Position(
                  longitude: lng!,
                  latitude: lat!,
                  timestamp: null,
                  accuracy: 0,
                  altitude: 0,
                  heading: 0,
                  speed: 0,
                  speedAccuracy: 0));
      if (place!.results!.isEmpty) {
        emit(NoResultsNearbyScheduleState());
      } else {
        emit(LoadNearbyScheduleSuccessState(nearbySchedule: place));
      }
    } on Exception catch (e) {
      emit(LoadNearbyScheduleFailedState(message: e.toString()));
    }
  }

  void refresh() {
    emit(LoadingNearbyScheduleState());
    getNearbyPlace('');
  }
}

//Nearby Place Suggestion
class NearbyPlaceSuggestionCubit extends Cubit<NearbyPlaceSuggestionState> {
  final Position location;

  NearbyPlaceSuggestionCubit(this.location)
      : super(NearbyPlaceSuggestionState()) {
    getNearbyPlaceSuggestion(location);
  }

  Future<void> getNearbyPlaceSuggestion(Position location) async {
    try {
      emit(LoadingNearbyPlaceSuggestionState());
      var place = await _foursquareRepo.getNearbyPlace('', location);
      if (place!.results!.isEmpty) {
        emit(NoResultsNearbyPlaceSuggestionState());
      } else {
        emit(LoadNearbyPlaceSuggestionSuccessState(nearbyPlace: place));
      }
    } on Exception catch (e) {
      emit(LoadNearbyPlaceSuggestionFailedState(message: e.toString()));
    }
  }

  void refresh() {
    emit(LoadingNearbyPlaceSuggestionState());
    getNearbyPlaceSuggestion(location);
  }
}
