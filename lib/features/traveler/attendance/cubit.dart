import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/repositories/activity_repo.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/features/traveler/attendance/state.dart';
import 'package:hypertrip/managers/firebase_manager.dart';
import 'package:hypertrip/utils/firebase_key.dart';
import 'package:hypertrip/utils/message.dart';

class TravelerAttendanceCubit extends Cubit<TravelerAttendanceState> {
  final ActivityRepo _activityRepo = getIt.get<ActivityRepo>();

  TravelerAttendanceCubit() : super(TravelerAttendanceState.initial());

  void reset() {
    emit(TravelerAttendanceState.initial());
  }

  Future<void> attend(String? code) async {
    if (code == null) return;
    emit(state.copyWith(attendanceSuccess: false, loading: true, error: null));
    try {
      await _activityRepo.attend(code);
      var data = await _fetchRealTimeDatabase(
          "${FirebaseKey.attendanceKey}/$code/${FirebaseKey.attendanceItems}/${UserRepo.profile?.id}/${FirebaseKey.attendancePresent}");

      if (data != null && data == true) {
        emit(state.copyWith(
            attendanceSuccess: true, loading: false, error: null));
      } else {
        // case BE response OK but on firebase not found
        emit(state.copyWith(
            attendanceSuccess: false, loading: false, error: msg_server_error));
      }
    } catch (e) {
      emit(state.copyWith(
          attendanceSuccess: false, loading: false, error: e.toString()));
    }
  }

  Future<Object?> _fetchRealTimeDatabase(String path) async {
    var db = FirebaseDatabase.instance.ref(path);
    DatabaseEvent event = await db.once();
    return event.snapshot.value;
  }
}
