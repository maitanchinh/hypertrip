class AttendanceActivityState {
  String? attendanceId;
  String title = '';

  AttendanceActivityState copyWith({
    String? attendanceId,
    String? title,
  }) {
    return AttendanceActivityState()
      ..attendanceId = attendanceId ?? this.attendanceId
      ..title = title ?? this.title;
  }
}

class AttendanceActivityLoadingState extends AttendanceActivityState {}

class AttendanceActivitySuccessState extends AttendanceActivityState {
  AttendanceActivitySuccessState(AttendanceActivityState state) {
    attendanceId = state.attendanceId;
    title = state.title;
  }
}

class AttendanceActivityErrorState extends AttendanceActivityState {
  final String message;

  AttendanceActivityErrorState({required this.message});
}
