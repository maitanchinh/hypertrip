part of '../view.dart';

Widget _buildCreateNew(BuildContext context) {
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
                showSheetModal(
                  context: context,
                  builder: (context) => const SelectTypeToCreateActivityModal(),
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
        ),
      ),
    ],
  );
}
