import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hypertrip/domain/repositories/group_repo.dart';
import 'package:hypertrip/domain/repositories/notification_repo.dart';
import 'package:hypertrip/domain/repositories/tour_repo.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/managers/firebase_messaging_manager.dart';
import 'package:hypertrip/utils/constant.dart';
import 'package:hypertrip/utils/get_it.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:nb_utils/nb_utils.dart';

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
