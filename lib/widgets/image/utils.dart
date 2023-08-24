import 'package:flutter/cupertino.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/utils/picture.dart';
import 'package:image_picker/image_picker.dart';

void showPickupImageSource(
  BuildContext context, {
  Function(List<String> imagePaths)? onImagePathsAdded,
  bool multiple = false,
}) {
  showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: const Text(label_use_camera),
          onPressed: () async {
            Navigator.pop(context);
            final image = await pickImage(ImageSource.camera);
            if (image != null) onImagePathsAdded?.call([image.path]);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(label_use_gallery),
          onPressed: () async {
            Navigator.pop(context);
            try {
              if (multiple) {
                final images = await pickMultipleImages();
                if (images.isNotEmpty) {
                  onImagePathsAdded
                      ?.call(images.map((image) => image.path).toList());
                }
                return;
              } else {
                final image = await pickImage(ImageSource.gallery);
                if (image != null) onImagePathsAdded?.call([image.path]);
                return;
              }
            } catch (e) {
              // Todo: handle error
              throw e;
            }
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(context),
        child: const Text(label_cancel),
      ),
    ),
  );
}
