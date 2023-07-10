import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/enums/activity_type.dart';
import 'package:hypertrip/features/public/current_tour/cubit.dart';
import 'package:hypertrip/features/public/current_tour/state.dart';
import 'package:hypertrip/features/tour_guide/activity/cubit.dart';
import 'package:hypertrip/features/tour_guide/activity/state.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/theme/text_style.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/popup/p_error_popup.dart';
import 'package:hypertrip/widgets/safe_space.dart';
import 'package:hypertrip/widgets/space/gap.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tuple/tuple.dart';

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
      activityCubit.getActivities(group.id);
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
      body: RefreshIndicator(
        onRefresh: () async {
          fetchData();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Search(),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
              )
            ],
          ),
        ),
      ),
    );
  }
}
