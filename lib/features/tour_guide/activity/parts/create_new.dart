part of '../view.dart';

Widget _buildCreateNew(BuildContext context, {required Function onReload}) {

  return Row(
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.bgLightColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SizedBox(
            height: ActivityConfig.btnHeight,
            child: TextButton(
              onPressed: () {
                final items = activitiesTypeData
                    .where((element) => element.type != ActivityType.All);
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: const Text("Select new activity type"),
                    actions: items
                        .map((e) => CupertinoActionSheetAction(
                              onPressed: () => _action(context, type: e.type),
                              child: Text(e.label),
                            ))
                        .toList(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.icons_plus_svg,
                    width: 18,
                    height: 18,
                    color: Colors.white,
                  ),
                  Gap.k4.width,
                  Text(
                    label_create_new_activity,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

void _action(BuildContext context, {required ActivityType type}) {
  Navigator.of(context).pop();
  if (type == ActivityType.All) return;
  if (type == ActivityType.Attendance) return _onCreateAttendance(context);
  if (type == ActivityType.CheckIn) return _onCreateCheckIn(context);
  if (type == ActivityType.IncurredCost) return _onCreateIncurredCosts(context);
}

void _onCreateAttendance(BuildContext context) {
  showAppModalBottomSheet(
      context: context, builder: (context) => const AttendanceActivity());
}

void _onCreateIncurredCosts(BuildContext context) {
  Navigator.of(context).pushNamed(IncurredCostsActivity.routeName);
}

void _onCreateCheckIn(BuildContext context) {
  showAppModalBottomSheet(context: context, builder: (context) =>  BlocProvider(create: (context) =>  CheckInActivityCubit(), child: const CheckInActivityScreen(),));
}
