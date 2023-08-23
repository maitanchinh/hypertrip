part of 'image_vertical_list.dart';

class ImageVerticalListTile extends StatefulWidget {
  final double height;
  final String imagePath;
  final Function()? onRemove;

  const ImageVerticalListTile({
    super.key,
    this.onRemove,
    this.height = 60,
    required this.imagePath,
  });

  @override
  State<ImageVerticalListTile> createState() => _ImageVerticalListTileState();
}

class _ImageVerticalListTileState extends State<ImageVerticalListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      // border
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Colors.grey[300]!,
        // ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: commonCachedNetworkImage(
              widget.imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 4,
            height: widget.height,
            child: Center(
              child: InkWell(
                onTap: () {
                  widget.onRemove?.call();
                },
                child: Icon(
                  Icons.close_sharp,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
