import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/features/traveler/attendance/cubit.dart';
import 'package:hypertrip/features/traveler/attendance/state.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/popup/p_error_popup.dart';
import 'package:nb_utils/nb_utils.dart';

class AttendanceStatus extends StatefulWidget {
  const AttendanceStatus({super.key});

  @override
  State<AttendanceStatus> createState() => _AttendanceStatusState();
}

class _AttendanceStatusState extends State<AttendanceStatus> {
  DatabaseReference? _dbRef;

  @override
  void initState() {
    _dbRef = FirebaseDatabase.instance.ref("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TravelerAttendanceCubit, TravelerAttendanceState>(
      listenWhen: (previous, current) => current.error != null,
      listener: (context, state) {
        showErrorPopup(context, content: state.error ?? '');
      },
      builder: (context, state) {
        var text =
            state.attendanceSuccess ? label_attended : label_not_attendance;
        var bg = state.attendanceSuccess
            ? AppColors.greenColor
            : AppColors.greyColor;
        var color = state.attendanceSuccess ? Colors.white : Colors.black54;

        return Container(
          width: double.infinity,
          color: bg,
          height: 50,
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
