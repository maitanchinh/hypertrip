import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hypertrip/domain/repositories/activity_repo.dart';
import 'package:hypertrip/exceptions/request_exception.dart';

import 'state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final ActivityRepo _activityRepo = ActivityRepo();
  final BuildContext context;

  ActivityCubit(this.context) : super(ActivityState());

  void getActivities(String tourGroupId) async {
    try {
      emit(ActivityInProgressState());
      var activities = await _activityRepo.getActivities(tourGroupId);
      debugPrint("activities: ${activities.map((e) => e.toJson())}");
      emit(ActivitySuccessState(activities));
    } on RequestException catch (error) {
      emit(ActivityFailureState(error.toString()));
    }
  }

  void setError(String message) {
    emit(ActivityFailureState(message));
  }

  void changeActivityType(String type) {
    emit(ActivityTypeChangedState(type));
  }
}
