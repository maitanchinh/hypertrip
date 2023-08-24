import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/features/public/schedule/cubit.dart';
import 'package:hypertrip/features/public/schedule/state.dart';
import 'package:hypertrip/features/public/tour_detail/cubit.dart';
import 'package:hypertrip/features/tour_guide/check_in/cubit.dart';
import 'package:hypertrip/features/tour_guide/check_in/parts/checkbox.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/widgets/app_bar.dart';
import 'package:hypertrip/widgets/safe_space.dart';
import 'package:hypertrip/widgets/space/gap.dart';
import 'package:hypertrip/widgets/text/p_small_text.dart';
import 'package:hypertrip/widgets/text/p_text.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../domain/models/schedule/slot.dart';
import '../activity/cubit.dart';

class CheckInActivityScreen extends StatefulWidget {
  const CheckInActivityScreen({super.key});
  static const String routeName = '/check_in';
  @override
  State<CheckInActivityScreen> createState() => _CheckInActivityScreenState();
}

class _CheckInActivityScreenState extends State<CheckInActivityScreen> {
  ActivityCubit? _activityCubit;
  CheckInActivityCubit? _checkInActivityCubit;
  String checkInScheduleId = '';
  String checkInScheduleTitle = '';
  Map<int, List<bool>> selectedCheckboxes = {};
  int? lastSelectedDay;
  @override
  void initState() {
    _activityCubit = BlocProvider.of<ActivityCubit>(context);
    _checkInActivityCubit = BlocProvider.of<CheckInActivityCubit>(context);
    super.initState();
  }

  Future<String?> _createNewCheckIn(String title, String scheduleId) async {
    // final cubit = BlocProvider.of<CheckInActivityCubit>(context);
    var state = _activityCubit!.state;

    var newCheckInId = await _checkInActivityCubit!.createNewCheckIn(
        tourGroupId: state.tourGroupId!,
        scheduleId: scheduleId,
        dayNo: state.selectedDay + 1,
        title: title);
    return newCheckInId;
  }

  @override
  Widget build(BuildContext context) {
    return SafeSpace.both(
      child: BlocProvider<CurrentTourCubit>(
        create: (context) => CurrentTourCubit(),
        child: BlocBuilder<CurrentTourCubit, CurrentTourState>(
            builder: (context, state) {
          if (state is LoadingCurrentTourState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoadCurrentTourSuccessState) {
            Map<int, List<Slot>> groupedSchedules = {};
            for (var schedule in state.schedule) {
              if (!groupedSchedules.containsKey(schedule.dayNo)) {
                groupedSchedules[schedule.dayNo!] = [];
              }
              groupedSchedules[schedule.dayNo]!.add(schedule);
            }
            if (state.schedule.indexWhere(
                    (element) => element.id == state.group.currentScheduleId) >
                0) {
              groupedSchedules.removeWhere((dayNo, _) =>
                  dayNo <
                  state
                      .schedule[state.schedule.indexWhere((element) =>
                          element.id == state.group.currentScheduleId)]
                      .dayNo!);
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: groupedSchedules.length,
                    itemBuilder: (context, index) {
                      int dayNo = groupedSchedules.keys.elementAt(index);
                      List<Slot> daySchedules = groupedSchedules[dayNo]!;
                      if (!selectedCheckboxes.containsKey(dayNo)) {
                        selectedCheckboxes[dayNo] =
                            List.filled(daySchedules.length, false);
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PText(
                              "Day $dayNo",
                              color: AppColors.textGreyColor,
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: daySchedules.length,
                            itemBuilder: (context, scheduleIndex) {
                              Slot schedule = daySchedules[scheduleIndex];
                              bool isSelected =
                                  selectedCheckboxes[dayNo]![scheduleIndex];

                              if (schedule.id ==
                                  state.group.currentScheduleId) {
                                isSelected = true;

                                // Update selected state for checkboxes before the current schedule
                                for (int i = 0; i < scheduleIndex; i++) {
                                  selectedCheckboxes[dayNo]![i] = true;
                                }
                              }

                              return ListTile(
                                title: PSmallText(
                                  schedule.title ?? "",
                                  size: 16,
                                  color: AppColors.textColor,
                                ),
                                subtitle: PSmallText(schedule.description),
                                trailing: schedule.sequence! >
                                  state.schedule
                                      .firstWhere((element) =>
                                          element.id == state.group.currentScheduleId)
                                      .sequence!
                                    ? CustomCheckbox(
                                        value: isSelected,
                                        onChanged: (newValue) {
                                          setState(() {
                                            // Update selected state for the current checkbox
                                            selectedCheckboxes[dayNo]![
                                                scheduleIndex] = newValue!;

                                            // Update selected state for checkboxes after the current checkbox
                                            if (isSelected) {
                                              for (int i = scheduleIndex + 1;
                                                  i < daySchedules.length;
                                                  i++) {
                                                selectedCheckboxes[dayNo]![i] =
                                                    false;
                                              }
                                            } else {
                                              for (int i = 0;
                                                  i < scheduleIndex;
                                                  i++) {
                                                selectedCheckboxes[dayNo]![i] =
                                                    newValue;
                                              }
                                            }

                                            if (newValue) {
                                              checkInScheduleId = schedule.id!;
                                              checkInScheduleTitle =
                                                  schedule.title!;
                                            }
                                          });
                                        },
                                      )
                                    : const SizedBox.shrink(),
                              ).paddingLeft(8);
                            },
                            separatorBuilder: (context, scheduleIndex) {
                              return Gap.k8.height;
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          String? result = await _createNewCheckIn(
                              checkInScheduleTitle, checkInScheduleId);

                          if (result != null) {
                            // Show a success toast
                            Fluttertoast.showToast(
                              msg: "Check-in created successfully!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: AppColors.primaryColor,
                              textColor: Colors.white,
                            );
                          } else {
                            // Show an error toast
                            Fluttertoast.showToast(
                              msg: "Error creating check-in. Please try again.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
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
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
