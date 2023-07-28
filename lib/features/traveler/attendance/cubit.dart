import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/repositories/activity_repo.dart';
import 'package:hypertrip/features/traveler/attendance/state.dart';
import 'package:hypertrip/managers/firebase_manager.dart';
import 'package:hypertrip/utils/message.dart';

class TravelerAttendanceCubit extends Cubit<TravelerAttendanceState> {
  final ActivityRepo _activityRepo = getIt.get<ActivityRepo>();

  TravelerAttendanceCubit() : super(TravelerAttendanceState.initial());

  Future<void> attend(String? code) async {
    if (code == null) return;

    emit(state.copyWith(loading: true));
    try {
      await _activityRepo.extend(code);
      emit(state.copyWith(attendanceSuccess: true, loading: false));
    } catch (e) {
      emit(state.copyWith(
        attendanceSuccess: false,
        loading: false,
        error: msg_invalid_code,
      ));
    }
  }
}
