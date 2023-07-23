import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/features/tour_guide/activity/cubit.dart';
import 'package:hypertrip/features/tour_guide/attendance_activity/cubit.dart';
import 'package:hypertrip/features/tour_guide/attendance_activity/state.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/p_text_form_field.dart';
import 'package:hypertrip/widgets/safe_space.dart';
import 'package:hypertrip/widgets/space/gap.dart';

class AttendanceActivity extends StatefulWidget {
  const AttendanceActivity({super.key});

  @override
  State<AttendanceActivity> createState() => _AttendanceActivityState();
}

class _AttendanceActivityState extends State<AttendanceActivity> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _createNewAttendance();
      debugPrint("AttendanceActivity: created new attendance");
      _onAttendanceChanged();
    });

    super.initState();
  }

  Future<void> _createNewAttendance() async {
    var activityState = BlocProvider.of<ActivityCubit>(context).state;
    var attendanceActivityCubit =
        BlocProvider.of<AttendanceActivityCubit>(context);

    if (activityState.tourGroupId == null) {
      attendanceActivityCubit
          .emit(AttendanceActivityFailure(message: msg_tour_group_not_found));
    } else {
      attendanceActivityCubit.createNewAttendance(
        tourGroupId: activityState.tourGroupId!,
        dayNo: activityState.selectedDay + 1,
      );
    }
  }

  void _onAttendanceChanged() {
    var attendanceActivityState =
        BlocProvider.of<AttendanceActivityCubit>(context).state;

    debugPrint("AttendanceActivity: listening attendance changed");
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("attendances/${attendanceActivityState.attendanceId}");
    debugPrint("AttendanceActivity: ${ref.path}");

    ref.onValue.listen((event) {
      debugPrint("AttendanceActivity: ${event.snapshot.value}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeSpace.both(
      child: Column(
        children: [
          const PTextFormField(label: "Title"),
          Gap.k8.height,
          BlocConsumer<AttendanceActivityCubit, AttendanceActivityState>(
            listener: (context, state) {
              if (state is AttendanceActivityFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              return SizedBox();
            },
          )
        ],
      ),
    );
  }
}
