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
import '../permission/cubit.dart';
import '../permission/state.dart';
import 'state.dart';

class CurrentTourCubit extends Cubit<CurrentTourState> {
  final GroupRepo _groupRepo = getIt<GroupRepo>();
  final TourRepo _tourRepo = getIt<TourRepo>();
  final NotificationRepo notificationRepo = getIt<NotificationRepo>();
  final UserRepo userRepo = getIt<UserRepo>();
  final FirebaseMessagingManager _firebaseMessagingManager = getIt<FirebaseMessagingManager>();

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

  void _registerFCMToken() async{
    final user = await userRepo.getProfile();
    _firebaseMessagingManager.registerTokenFCM(user.id ?? '');
  }
}

final FoursquareRepo _foursquareRepo = getIt<FoursquareRepo>();

//Nearby Place
class NearbyPlaceCubit extends Cubit<NearbyPlaceState> {
  final CurrentLocationCubit currentLocationCubit;
  final String query;

  NearbyPlaceCubit(this.currentLocationCubit, this.query) : super(NearbyPlaceState()) {
    getNearbyPlace(query);
  }


  Future<void> getNearbyPlace(String query) async {
    try {
      emit(LoadingNearbyPlaceState());
      var place = await _foursquareRepo.getNearbyPlace(
          query,
          currentLocationCubit.state is LoadCurrentLocationSuccessState ? (currentLocationCubit.state as LoadCurrentLocationSuccessState)
              .location : Position(longitude: 0, latitude: 0, timestamp: null, accuracy: 0, altitude: 0, heading: 0, speed: 0, speedAccuracy: 0));
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