import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/utils/picture.dart';
import 'package:hypertrip/widgets/image/image.dart';
import 'package:hypertrip/widgets/image/more_overlay.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class Gallery extends StatefulWidget {
  final int visibleAmount;
  final List<String> imagePaths;
  final Function(List<String> imagePaths)? onImagePathsChanged;
  final bool allowAdd;
  final bool allowRemove;
  final bool isMultiple;

  const Gallery({
    super.key,
    this.visibleAmount = 4,
    this.imagePaths = const [],
    this.allowAdd = false,
    this.allowRemove = false,
    this.onImagePathsChanged,
    this.isMultiple = false,
  });

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<String> _imagePaths = [];

  @override
  void initState() {
    _imagePaths = widget.imagePaths;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var itemCount = widget.imagePaths.length > widget.visibleAmount
        ? widget.visibleAmount
        : widget.imagePaths.length;

    /// add last button to add new item
    if (widget.allowAdd) itemCount++;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.visibleAmount,
        crossAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        /// Add button
        final isLast = index == itemCount - 1;
        if (isLast && widget.allowAdd) {
          return _buildAddButton(
            onTap: () => _showPickupImageSource(
              context,
              widget.isMultiple,
              (imagePaths) {
                final newImagePaths = [..._imagePaths, ...imagePaths];
                widget.onImagePathsChanged?.call(newImagePaths);
                setState(() {
                  _imagePaths = newImagePaths;
                });
              },
            ),
          );
        }

        final path = widget.imagePaths[index];
        final hasOverlay = widget.imagePaths.length > widget.visibleAmount &&
            index == widget.visibleAmount - 1;
        final moreItem = widget.imagePaths.length - widget.visibleAmount + 1;

        /// Last item overlay
        if (hasOverlay) {
          return _withMoreItemOverlay(_buildItem(path), moreItem);
        }

        /// Normal item
        return _buildItem(path);
      },
    );
  }
}

Widget _buildAddButton({void Function()? onTap}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: AppColors.lightGreyColor,
    ),
    child: const Icon(Icons.add),
  ).onTap(onTap);
}

Widget _withMoreItemOverlay(Widget child, int moreItem) => Stack(
      fit: StackFit.expand,
      children: [
        child,
        IgnorePointer(child: MoreOverlay('+$moreItem')),
      ],
    );

Widget _buildItem(String imagePath) => GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => PlacePhotoScreen(
        //               photos: place.photos,
        //               currentPhotoIndex: index,
        //             )));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.lightGreyColor,
        ),
        child: commonCachedNetworkImage(
          imagePath,
          fit: BoxFit.contain,
        ),
      ),
    );

void _showPickupImageSource(BuildContext context, bool isMultiple,
    Function(List<String> imagePath)? onImagePathsAdded) {
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
            var images = await pickMultipleImages();
            onImagePathsAdded?.call(images.map((image) => image.path).toList());
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
