import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/models/activity/firebase_attendance_model.dart';
import 'package:hypertrip/features/tour_guide/activity/cubit.dart';
import 'package:hypertrip/features/tour_guide/attendance_activity/cubit.dart';
import 'package:hypertrip/features/tour_guide/attendance_activity/parts/qr_code_image.dart';
import 'package:hypertrip/features/tour_guide/attendance_activity/parts/user_list.dart';
import 'package:hypertrip/features/tour_guide/attendance_activity/state.dart';
import 'package:hypertrip/utils/firebase_key.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/popup/p_error_popup.dart';
import 'package:hypertrip/widgets/safe_space.dart';
import 'package:nb_utils/nb_utils.dart';

class AttendanceActivity extends StatefulWidget {
  final String? attendanceId;
  const AttendanceActivity({super.key, this.attendanceId});

  @override
  State<AttendanceActivity> createState() => _AttendanceActivityState();
}

class _AttendanceActivityState extends State<AttendanceActivity> {
  ActivityCubit? _activityCubit;
  AttendanceActivityCubit? _attendanceActivityCubit;
  DatabaseReference? _dbRef;
  final TextEditingController _titleController = TextEditingController();
  bool _isNew = false;
  bool _saved = false;
  String? _attendanceId;

  @override
  void dispose() {
    // remove if not saved
    if (_isNew && _attendanceId != null && !_saved) {
      _attendanceActivityCubit!.removeDraft(_attendanceId!);
    }

    // reload if save new attendance
    if (_saved) {
      _reloadActivity();
    }

    super.dispose();
  }

  void _reloadActivity() {
    var state = _activityCubit!.state;
    _activityCubit!.getActivities(
        totalDays: state.totalDays, tourGroupId: state.tourGroupId!);
  }

  @override
  void initState() {
    _attendanceId = widget.attendanceId;
    _isNew = widget.attendanceId == null;
    _activityCubit = BlocProvider.of<ActivityCubit>(context);
    _attendanceActivityCubit =
        BlocProvider.of<AttendanceActivityCubit>(context);

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // create new attendance if attendanceId is null
      _attendanceId ??= await _createNewAttendance();
      _dbRef = FirebaseDatabase.instance.ref(
          "${FirebaseKey.attendanceKey}/$_attendanceId/${FirebaseKey.attendanceItems}");
      await _fetchData(_attendanceId);
    });

    super.initState();
  }

  Future<String?> _createNewAttendance() async {
    var state = _activityCubit!.state;

    var newAttendanceId = await _attendanceActivityCubit!.createNewAttendance(
      tourGroupId: state.tourGroupId!,
      dayNo: state.selectedDay + 1,
    );

    return newAttendanceId;
  }

  Future<void> _fetchData(String? attendanceId) async {
    var isNew = widget.attendanceId == null;

    if (attendanceId == null) {
      return;
    }

    var cubit = BlocProvider.of<AttendanceActivityCubit>(context);
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("${FirebaseKey.attendanceKey}/$attendanceId");

    DatabaseEvent event = await ref.once();

    if (event.snapshot.value != null) {
      cubit.setData(
        attendanceId: attendanceId,
        title: (event.snapshot.value as dynamic)[FirebaseKey.attendanceTitle] ??
            "",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeSpace.both(
      child: BlocConsumer<AttendanceActivityCubit, AttendanceActivityState>(
        listener: (context, state) {
          if (state is AttendanceActivityErrorState) {
            showErrorPopup(context, content: state.message);
          }
        },
        builder: (context, state) {
          if (state is AttendanceActivityLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AttendanceActivityErrorState) {
            return const Center(child: Text(msg_cannot_load_attendance_member));
          }

          _titleController.text = state.title;

          return Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Title is required' : null,
                controller: _titleController,
              ),
              16.height,
              QrCodeImage(
                data: state.attendanceId,
              ),
              16.height,
              Expanded(
                child: BlocBuilder<AttendanceActivityCubit,
                    AttendanceActivityState>(
                  buildWhen: (previous, current) => false,
                  builder: (context, state) {
                    return StreamBuilder(
                      stream: _dbRef?.onValue,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot.hasData &&
                            snapshot.data != null &&
                            snapshot.data!.snapshot.value != null) {
                          var data = FirebaseAttendanceItem.fromPayload(
                              snapshot.data!.snapshot.value!);

                          return UserList(data: data);
                        } else {
                          return const Center(
                              child: Text(msg_cannot_load_attendance_member));
                        }
                      },
                    );
                  },
                ),
              ),
              // Button
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_titleController.text.isNotEmpty) {
                          _saved = true;
                          Navigator.pop(context);
                          _attendanceActivityCubit!
                              .saveAttendance(title: _titleController.text);
                        } else {
                          Fluttertoast.showToast(
                            msg: "Title is required",
                            toastLength: Toast
                                .LENGTH_SHORT, 
                            gravity: ToastGravity
                                .BOTTOM, 
                            timeInSecForIosWeb:
                                1,
                            backgroundColor:
                                Colors.grey, 
                            textColor: Colors.white,
                          );
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
