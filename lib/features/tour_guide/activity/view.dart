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
import 'package:hypertrip/extensions/datetime.dart';
import 'package:hypertrip/extensions/enum.dart';
import 'package:hypertrip/features/root/cubit.dart';
import 'package:hypertrip/features/root/root_guard.dart';
import 'package:hypertrip/features/root/state.dart';
import 'package:hypertrip/features/tour_guide/activity/cubit.dart';
import 'package:hypertrip/features/tour_guide/activity/state.dart';
import 'package:hypertrip/features/tour_guide/attendance_activity/view.dart';
import 'package:hypertrip/features/tour_guide/incurred_costs_activity/view.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/app_bar.dart';
import 'package:hypertrip/widgets/modals/show_bottom_sheet.dart';
import 'package:hypertrip/widgets/popup/p_error_popup.dart';
import 'package:hypertrip/widgets/safe_space.dart';
import 'package:hypertrip/widgets/space/gap.dart';
import 'package:nb_utils/nb_utils.dart';

import 'common/activity_data.dart';
import 'common/config.dart';

part 'parts/activity_empty.dart';
part 'parts/activity_error.dart';
part 'parts/app_bar.dart';
part 'parts/create_new.dart';
part 'parts/day_picker.dart';
part 'parts/filter_type_modal.dart';
part 'parts/list_activity.dart';
part 'parts/search.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await fetchData();
    });
    super.initState();
  }

  Future<void> fetchData() async {
    var rootCubit = BlocProvider.of<RootCubit>(context);
    var rootState = rootCubit.state as RootSuccessState;

    if (rootState.group == null) {
      rootCubit.load();
    }

    var activityCubit = context.read<ActivityCubit>();
    activityCubit.getActivities(
      tourGroupId: rootState.group!.id!,
      totalDays: rootState.group!.totalDays!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLightColor,
      appBar: const MainAppBar(
        title: 'Activity',
        implyLeading: false,
      ),
      bottomNavigationBar: _buildCreateNew(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            const Search(),
            Expanded(
              flex: 1,
              child: RefreshIndicator(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: RootGuard(
                    errorWidget: const ActivityError(),
                    child: BlocConsumer<ActivityCubit, ActivityState>(
                      listener: (context, state) {
                        if (state is ActivityErrorState) {
                          showErrorPopup(context, content: state.message);
                          return;
                        }
                      },
                      builder: (context, state) {
                        // Loading
                        if (state is ActivityLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        // Error
                        if (state is ActivityErrorState) {
                          return const ActivityEmpty();
                        }

                        // Success
                        if (state is ActivitySuccessState) {
                          return Column(
                            children: [
                              const DayPicker(),
                              16.height,
                              const Expanded(
                                child: ListActivity(),
                              ),
                            ],
                          );
                        }

                        return const ActivityEmpty();
                      },
                    ),
                  ),
                ),
                onRefresh: () async => await fetchData(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
