part of '../view.dart';

class ImageCollection extends StatefulWidget {
  const ImageCollection({super.key});

  @override
  State<ImageCollection> createState() => _ImageCollectionState();
}

class _ImageCollectionState extends State<ImageCollection> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<IncurredCostsActivityCubit>(context);

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: AppColors.lightGreyColor,
            ),
            child: Center(
              child: SvgPicture.asset(
                AppAssets.icons_image_file_add_svg,
                width: 60,
                colorFilter: const ColorFilter.mode(
                  AppColors.textGreyColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          )
        ],
      ),
    ).onTap(() {
      // show bottom sheet options
    });
  }
}
