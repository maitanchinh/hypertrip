import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/repositories/activity_repo.dart';
import 'package:hypertrip/features/tour_guide/check_in/state.dart';

import '../../../managers/firebase_manager.dart';

class CheckInActivityCubit extends Cubit<CheckInActivityState>{
  final ActivityRepo _activityRepo = getIt.get<ActivityRepo>();
  CheckInActivityCubit() : super (CheckInActivityState());

  Future<String?> createNewCheckIn({required String scheduleId ,required String tourGroupId, required int dayNo, required String title}) async {
    String? id;
    emit(CheckInActivityLoadingState());
    try {
      await _activityRepo.setCurrentSchedule(tourGroupId, scheduleId);
      id = await _activityRepo.createNewCheckIn(tourGroupId: tourGroupId, dayNo: dayNo, title: title);
      emit(CheckInActivitySuccessState(state.copyWith(
        checkInId: id
      )));
    } catch (e) {
      emit(CheckInActivityErrorState(msg: e.toString()));
    }
    return id;
  }
}