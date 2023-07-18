part of '../view.dart';

class ListActivity extends StatefulWidget {
  const ListActivity({super.key});

  @override
  State<ListActivity> createState() => _ListActivityState();
}

class _ListActivityState extends State<ListActivity> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityCubit, ActivityState>(
      listener: (context, state) {},
      builder: (context, state) {
        var activities = state.filteredActivities;

        return ListView.separated(
          shrinkWrap: true,
          itemCount: activities.length,
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            thickness: 1,
          ),
          itemBuilder: (context, index) =>
              _buildSlidable(context, activities, index),
        );
      },
    );
  }
}

Widget _buildSlidable(
    BuildContext context, List<Activity> activities, int index) {
  return Slidable(
    // key: activities[index].data['id'],
    //* Left side
    startActionPane: ActionPane(
      motion: const DrawerMotion(),
      extentRatio: 0.25,
      // dismissible: DismissiblePane(onDismissed: () {}),
      children: [
        CustomSlidableAction(
          onPressed: null,
          backgroundColor: AppColors.lightGreenColor,
          foregroundColor: Colors.white,
          child: SvgPicture.asset(
            AssetIcons.circleCheckRegular1,
            width: 24,
            height: 24,
          ),
        ),
      ],
    ),
    //* Right side
    endActionPane: ActionPane(
      motion: const DrawerMotion(),
      extentRatio: 0.25,
      // dismissible: DismissiblePane(onDismissed: () {}),
      children: [
        CustomSlidableAction(
          onPressed: null,
          backgroundColor: AppColors.lightGreenColor,
          foregroundColor: Colors.white,
          child: SvgPicture.asset(
            AssetIcons.circleCheckRegular1,
            width: 24,
            height: 24,
          ),
        ),
      ],
    ),
    child: _buildActivity(context, activities[index]),
  );
}

Widget _buildActivity(BuildContext context, Activity activity) {
  var config = {
    "height": 80.0,
  };
  var type = activity.type ?? "";

  if (ActivityType.Attendance.compareWithString(type)) {
    return _buildAttendanceActivity(
        context, AttendanceActivityModel.fromJson(activity.data), config);
  }
  if (ActivityType.CheckIn.compareWithString(type)) {
    return _buildCheckInActivity(
        context, CheckInActivity.fromJson(activity.data), config);
  }
  if (ActivityType.Custom.compareWithString(type)) {
    return _buildCustomActivity(
        context, CustomActivity.fromJson(activity.data), config);
  }

  return const SizedBox();
}

Widget _buildAttendanceActivity(
    BuildContext context, AttendanceActivityModel activity, config) {
  return Container(
    color: Colors.white,
    width: double.infinity,
    height: config['height'],
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SvgPicture.asset(
            AssetIcons.circleCheckRegular1,
            width: 24,
            height: 24,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              activity.title ?? "",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Gap.k4.height,
            Text(
              activity.createdAt.toString(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.textGreyColor,
                  ),
            )
          ],
        ),
      ],
    ),
  );
}

Widget _buildCheckInActivity(
    BuildContext context, CheckInActivity activity, config) {
  return Container(
    color: Colors.white,
    width: double.infinity,
    height: config['height'],
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SvgPicture.asset(
            AssetIcons.checkIn,
            width: 24,
            height: 24,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              activity.title ?? "",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Gap.k4.height,
            Text(
              activity.createdAt.toString(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.textGreyColor,
                  ),
            )
          ],
        ),
      ],
    ),
  );
}

Widget _buildCustomActivity(
    BuildContext context, CustomActivity activity, config) {
  return Container(
    color: Colors.white,
    width: double.infinity,
    height: config['height'],
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SvgPicture.asset(
            AssetIcons.circleCheckRegular1,
            width: 24,
            height: 24,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              activity.title ?? "",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Gap.k4.height,
            Text(
              activity.createdAt.toString(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.textGreyColor,
                  ),
            )
          ],
        ),
      ],
    ),
  );
}
