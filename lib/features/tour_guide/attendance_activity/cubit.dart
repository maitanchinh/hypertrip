import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/repositories/activity_repo.dart';
import 'package:hypertrip/features/tour_guide/attendance_activity/state.dart';
import 'package:hypertrip/utils/get_it.dart';

class AttendanceActivityCubit extends Cubit<AttendanceActivityState> {
  final ActivityRepo _activityRepo = getIt.get<ActivityRepo>();

  AttendanceActivityCubit() : super(AttendanceActivityState());

  Future<void> createNewAttendance({
    required String tourGroupId,
    required int dayNo,
  }) async {
    emit(AttendanceActivityInProcess());
    try {
      var id = await _activityRepo.createNewAttendance(
          tourGroupId: tourGroupId, dayNo: dayNo);

      emit(AttendanceActivitySuccess(attendanceId: id));
    } catch (e) {
      emit(AttendanceActivityFailure(message: e.toString()));
    }
  }
}
