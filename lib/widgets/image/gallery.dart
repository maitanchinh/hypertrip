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
  final int? limit;

  const Gallery({
    super.key,
    this.visibleAmount = 4,
    this.imagePaths = const [],
    this.allowAdd = false,
    this.allowRemove = false,
    this.onImagePathsChanged,
    this.limit,
  })  : assert(limit == null || limit > 0),
        assert(visibleAmount > 0);

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
    var itemCount = _imagePaths.length > widget.visibleAmount
        ? widget.visibleAmount
        : _imagePaths.length;

    final hasAddButton = widget.allowAdd &&
        (widget.limit == null || _imagePaths.length < widget.limit!);

    /// add last button to add new item
    if (hasAddButton) itemCount++;

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
        if (isLast && hasAddButton) {
          return _buildAddButton(
            onTap: () => _showPickupImageSource(
              context,
              widget.limit,
              (imagePaths) {
                var newImagePaths = [..._imagePaths, ...imagePaths];
                if (widget.limit != null) {
                  newImagePaths = newImagePaths
                      .sublist(newImagePaths.length - widget.limit!);
                }
                widget.onImagePathsChanged?.call(newImagePaths);
                setState(() {
                  _imagePaths = newImagePaths;
                });
              },
            ),
          );
        }

        final path = _imagePaths[index];
        final hasOverlay = _imagePaths.length > widget.visibleAmount &&
            index == widget.visibleAmount - 1;
        final moreItem = _imagePaths.length - widget.visibleAmount + 1;

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
    child: const Icon(
      Icons.add,
      color: AppColors.textGreyColor,
    ),
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

void _showPickupImageSource(BuildContext context, int? limit,
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
