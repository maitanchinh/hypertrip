import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/features/traveler/attendance/cubit.dart';
import 'package:hypertrip/features/traveler/attendance/state.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:nb_utils/nb_utils.dart';

class AttendanceStatus extends StatefulWidget {
  const AttendanceStatus({super.key});

  @override
  State<AttendanceStatus> createState() => _AttendanceStatusState();
}

class _AttendanceStatusState extends State<AttendanceStatus> {
  @override
  void initState() {
    context.read<TravelerAttendanceCubit>().reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TravelerAttendanceCubit, TravelerAttendanceState>(
      builder: (context, state) {
        debugPrint(state.toString());

        var text =
            state.attendanceSuccess ? label_attended : label_not_attendance;
        var bg = state.attendanceSuccess
            ? AppColors.greenColor
            : AppColors.greyColor;
        var color = state.attendanceSuccess ? Colors.white : Colors.black54;

        return Container(
          width: double.infinity,
          color: bg,
          height: context.height() * 0.1 + 50,
          child: Center(
              child: Text(
            text,
            style: boldTextStyle(color: color),
          )),
        );
      },
    );
  }
}
