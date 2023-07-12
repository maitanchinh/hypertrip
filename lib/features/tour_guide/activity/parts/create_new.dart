part of '../view.dart';

Widget _buildCreateNew(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: TextButton(
          onPressed: () {
            showCupertinoModalBottomSheet(
              expand: false,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => AttendanceForm(),
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetIcons.plus,
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
    ],
  );
}
