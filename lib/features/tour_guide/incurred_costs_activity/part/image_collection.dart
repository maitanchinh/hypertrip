part of '../view.dart';

class ImageCollection extends StatefulWidget {
  const ImageCollection({super.key});

  @override
  State<ImageCollection> createState() => _ImageCollectionState();
}

class _ImageCollectionState extends State<ImageCollection> {
  void showPictureSourceSelector() {}

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<IncurredCostsActivityCubit>(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.fromBorderSide(
          BorderSide(color: AppColors.cardBorderColor),
        ),
      ),
      child: Column(
        children: [
          BlocBuilder<IncurredCostsActivityCubit, IncurredCostsActivityState>(
            builder: (context, state) {
              return ImageVerticalList(
                key: UniqueKey(),
                imagePaths: state.imagePaths,
                limit: 1,
                onChanged: (imagePaths) => cubit.setImagePaths(imagePaths),
              );
            },
          ),
        ],
      ),
      // SizedBox(
      //   width: double.infinity,
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Container(
      //         padding: const EdgeInsets.all(16),
      //         decoration: const BoxDecoration(
      //           borderRadius: BorderRadius.all(Radius.circular(8)),
      //           color: AppColors.lightGreyColor,
      //         ),
      //         child: Center(
      //           child: SvgPicture.asset(
      //             AppAssets.icons_image_file_add_svg,
      //             width: 60,
      //             colorFilter: const ColorFilter.mode(
      //               AppColors.textGreyColor,
      //               BlendMode.srcIn,
      //             ),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ).onTap(() {
      //   // show bottom sheet options
      //   showCupertinoModalPopup(
      //     context: context,
      //     builder: (context) => CupertinoActionSheet(
      //       actions: [
      //         CupertinoActionSheetAction(
      //           child: const Text(label_use_camera),
      //           onPressed: () => pickImageFromCamera(context),
      //         ),
      //         CupertinoActionSheetAction(
      //           child: const Text(label_use_gallery),
      //           onPressed: () => pickImageFromGallery(context),
      //         )
      //       ],
      //       cancelButton: CupertinoActionSheetAction(
      //         onPressed: () => Navigator.pop(context),
      //         child: const Text(label_cancel),
      //       ),
      //     ),
      //   );
      // }),
    );
  }

  void pickImageFromCamera(BuildContext context) async {
    Navigator.pop(context);
    final image = await pickImage(ImageSource.camera);
    if (image != null) addAnImageIntoState(image);
  }

  void pickImageFromGallery(BuildContext context) async {
    Navigator.pop(context);
    final images = await pickMultipleImages();
    if (images.isNotEmpty) addMultipleImagesIntoState(images);
  }

  void addMultipleImagesIntoState(List<File> images) {}
  void addAnImageIntoState(File images) {}

  Widget _buildImage(File image) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: FileImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
