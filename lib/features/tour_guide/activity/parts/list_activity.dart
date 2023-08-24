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
        if (activities.isEmpty) return const ActivityEmpty();

        return ListView.separated(
          shrinkWrap: true,
          itemCount: activities.length,
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            thickness: 1,
          ),
          itemBuilder: (context, index) =>
              _buildSlidable(context, activities[index]),
        );
      },
    );
  }
}

Widget _buildSlidable(BuildContext context, Activity activitiy) {
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
            AppAssets.icons_circle_check_regular_1_svg,
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
            AppAssets.icons_circle_check_regular_1_svg,
            width: 24,
            height: 24,
          ),
        ),
      ],
    ),
    child: _buildActivity(context, activitiy),
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

  if (ActivityType.IncurredCost.compareWithString(type)) {
    return _buildIncurredCostActivity(
        context, IncurredCostActivityModel.fromJson(activity.data), config);
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
          child: _buildTileIcon(context, 1),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PText(
              activity.title ?? "",
              // style: Theme.of(context).textTheme.titleMedium!.copyWith(
              //       color: AppColors.textColor,
              //       fontWeight: FontWeight.w600,
              //     ),
            ),
            Gap.k4.height,
            _buildDate(context, activity.createdAt),
            Gap.k4.height,
            // Text(
            //   activity.createdAt.readableDateTimeValue,
            //   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            //         color: AppColors.textColor,
            //       ),
            // )
            _buildBadge(context, 1)
          ],
        ),
      ],
    ),
  ).onTap(() {
    showAppModalBottomSheet(
      expand: true,
      context: context,
      builder: (context) => AttendanceActivity(attendanceId: activity.id),
    );
  });
}

Widget _buildIncurredCostActivity(
    BuildContext context, IncurredCostActivityModel activity, config) {
  return Container(
    padding: const EdgeInsets.only(right: 24),
    color: Colors.white,
    width: double.infinity,
    height: config['height'],
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildTileIcon(context, 3),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PText(
                activity.note ?? "",
                // style: Theme.of(context).textTheme.titleMedium!.copyWith(
                //       color: AppColors.textColor,
                //       fontWeight: FontWeight.w600,
                //     ),
              ),
              Gap.k4.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDate(context, activity.createdAt),
                      Gap.k4.height,
                      _buildBadge(context, 3)
                    ],
                  ),
                  Text(
                    CurrencyFormatter.vi.format(activity.cost.toString()),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ).onTap(() {
    showAppModalBottomSheet(
      expand: true,
      context: context,
      builder: (context) => AttendanceActivity(attendanceId: activity.id),
    );
  });
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
          child: _buildTileIcon(context, 2),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PText(
              activity.title ?? "",
              // style: Theme.of(context).textTheme.titleMedium!.copyWith(
              //       color: AppColors.textColor,
              //       fontWeight: FontWeight.w600,
              //     ),
            ),
            Gap.k4.height,

            _buildDate(context, activity.createdAt),
            Gap.k4.height,
            // Text(
            //   activity.createdAt.readableDateTimeValue,
            //   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            //         color: AppColors.textColor,
            //       ),
            // )
            _buildBadge(context, 2)
          ],
        ),
      ],
    ),
  );
}

Widget _buildTileIcon(BuildContext context, int type) {
  return Container(
    width: 24,
    height: 24,
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: Center(
      child: SvgPicture.asset(
        activitiesTypeData[type].icon,
        colorFilter:
            ColorFilter.mode(activitiesTypeData[type].color, BlendMode.srcIn),
      ),
    ),
  );
}

Widget _buildBadge(BuildContext context, int type) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    decoration: BoxDecoration(
      color: activitiesTypeData[type].color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: PSmallText(
      activitiesTypeData[type].label.toLowerCase(), size: 8, color: white,
      // style: const TextStyle(
      //   fontSize: 8,
      //   color: Colors.white,
      //   fontWeight: FontWeight.bold,
      // ),
    ),
  );
}

Widget _buildDate(BuildContext context, DateTime? date) {
  const height = 11;

  if (date == null) return height.height;

  return SizedBox(
    // height: height.toDouble(),
    child: PSmallText(
      date.readableDateTimeValue,
      // style: const TextStyle(
      //   color: AppColors.textGreyColor,
      //   fontSize: 10,
      // ),
    ),
  );
}
