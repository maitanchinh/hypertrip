import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hypertrip/domain/enums/activity_type.dart';
import 'package:hypertrip/domain/models/activity/activity.dart';
import 'package:hypertrip/domain/models/activity/attendance_activity.dart';
import 'package:hypertrip/domain/models/activity/check_in_activity.dart';
import 'package:hypertrip/domain/models/activity/custom_activity.dart';
import 'package:hypertrip/extensions/enum.dart';
import 'package:hypertrip/features/public/current_tour/cubit.dart';
import 'package:hypertrip/features/public/current_tour/state.dart';
import 'package:hypertrip/features/tour_guide/activity/cubit.dart';
import 'package:hypertrip/features/tour_guide/activity/state.dart';
import 'package:hypertrip/r.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/modals/show_sheet_modal.dart';
import 'package:hypertrip/widgets/popup/p_error_popup.dart';
import 'package:hypertrip/widgets/safe_space.dart';
import 'package:hypertrip/widgets/space/gap.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tuple/tuple.dart';

part 'parts/config.dart';
part 'parts/create_new.dart';
part 'parts/day_picker.dart';
part 'parts/list_activity.dart';
part 'parts/modals/filter_type_modal.dart';
part 'parts/modals/select_type_to_create_activity_modal.dart';
part 'parts/search.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });

    super.initState();
  }

  void fetchData() {
    final currentTourCubit = BlocProvider.of<CurrentTourCubit>(context);
    final currentTourState = currentTourCubit.state;
    final activityCubit = BlocProvider.of<ActivityCubit>(context);
    if (currentTourState is LoadCurrentTourSuccessState) {
      final group = currentTourState.group;
      final totalDays = currentTourState.getDays().last;
      activityCubit.getActivities(tourGroupId: group.id, totalDays: totalDays);
    } else {
      activityCubit.setError(msg_tour_group_not_found);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLightColor,
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.of(context).pop();
        }),
        title: Text(
          label_activity,
          // color white
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
      ),
      bottomNavigationBar: _buildCreateNew(context),
      body: RefreshIndicator(
        onRefresh: () async {
          fetchData();
        },
        child: Column(
          children: [
            BlocListener<ActivityCubit, ActivityState>(
              listener: (context, state) {
                if (state is ActivityFailureState) {
                  showErrorPopup(context, content: state.message);
                }
              },
              child: Gap.kZero,
            ),
            Container(
              color: AppColors.bgLightColor,
              child: Column(
                children: [
                  Gap.k16.height,
                  //* Search
                  const Search(),
                  //* Loading
                  BlocBuilder<ActivityCubit, ActivityState>(
                      builder: (context, state) {
                    if (state is ActivityInProgressState) {
                      return Column(
                        children: [
                          Gap.k4.height,
                          const Center(child: CircularProgressIndicator()),
                        ],
                      );
                    }
                    return Gap.kZero;
                  }),
                  Gap.k16.height,
                  //* Day picker
                  const DayPicker(),
                ],
              ),
            ),
            Gap.k16.height,
            //* List activity
            const Expanded(child: ListActivity())
          ],
        ),
      ),
    );
  }
}
