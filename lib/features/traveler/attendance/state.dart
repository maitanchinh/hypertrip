import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class TravelerAttendanceState extends Equatable {
  final bool attendanceSuccess;
  final bool loading;
  final String? error;

  const TravelerAttendanceState(
      {required this.attendanceSuccess, required this.loading, this.error});

  factory TravelerAttendanceState.initial() => const TravelerAttendanceState(
        attendanceSuccess: false,
        loading: false,
      );

  copyWith({
    bool? attendanceSuccess,
    bool? loading,
    String? error,
  }) =>
      TravelerAttendanceState(
        attendanceSuccess: attendanceSuccess ?? this.attendanceSuccess,
        loading: loading ?? this.loading,
        error: error,
      );

  @override
  List<Object?> get props => [attendanceSuccess, loading];
}
