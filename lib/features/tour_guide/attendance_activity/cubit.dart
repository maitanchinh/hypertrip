import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/enums/activity_type.dart';
import 'package:hypertrip/domain/repositories/activity_repo.dart';
import 'package:hypertrip/features/tour_guide/attendance_activity/state.dart';
import 'package:hypertrip/utils/get_it.dart';

class AttendanceActivityCubit extends Cubit<AttendanceActivityState> {
  final ActivityRepo _activityRepo = getIt.get<ActivityRepo>();

  AttendanceActivityCubit() : super(AttendanceActivityState());

  Future<String?> createNewAttendance({
    required String tourGroupId,
    required int dayNo,
  }) async {
    String? id;

    emit(AttendanceActivityLoadingState());

    try {
      id = await _activityRepo.createNewAttendance(
        tourGroupId: tourGroupId,
        dayNo: dayNo,
      );

      emit(AttendanceActivitySuccessState(state.copyWith(
        attendanceId: id,
        title: '',
      )));
    } catch (e) {
      emit(AttendanceActivityErrorState(message: e.toString()));
    }

    return id;
  }

  void setData({required String attendanceId, required String title}) {
    emit(AttendanceActivitySuccessState(state.copyWith(
      attendanceId: attendanceId,
      title: title,
    )));
  }

  void setError({required String message}) {
    emit(AttendanceActivityErrorState(message: message));
  }

  void removeDraft(String attendanceId) {
    _activityRepo.removeDraft(attendanceId);
  }

  Future<void> saveAttendance({required String title}) async {
    try {
      await _activityRepo.patchUpdate({
        "type": ActivityType.Attendance.name,
        "attendanceActivity": {
          "id": state.attendanceId,
          "title": title,
        }
      });
    } catch (e) {
      var oldState = state;
      emit(AttendanceActivityErrorState(message: e.toString()));
      emit(AttendanceActivitySuccessState(oldState));
    }
  }
}
