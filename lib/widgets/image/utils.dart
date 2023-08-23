import 'package:flutter/cupertino.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/utils/picture.dart';
import 'package:image_picker/image_picker.dart';

void showPickupImageSource(
  BuildContext context, {
  Function(List<String> imagePaths)? onImagePathsAdded,
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
              var images = await pickMultipleImages();
              onImagePathsAdded
                  ?.call(images.map((image) => image.path).toList());
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
