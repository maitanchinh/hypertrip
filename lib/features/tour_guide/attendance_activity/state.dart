class AttendanceActivityState {
  String? attendanceId;
}

class AttendanceActivityInProcess extends AttendanceActivityState {}

class AttendanceActivitySuccess extends AttendanceActivityState {
  AttendanceActivitySuccess({required String attendanceId}) {
    this.attendanceId = attendanceId;
  }
}

class AttendanceActivityFailure extends AttendanceActivityState {
  final String message;

  AttendanceActivityFailure({required this.message});
}
