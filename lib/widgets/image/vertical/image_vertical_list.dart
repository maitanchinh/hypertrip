import 'package:flutter/material.dart';
import 'package:hypertrip/widgets/image/image.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils.dart';

part 'add_new_button.dart';
part 'image_vertical_list_tile.dart';

class ImageVerticalList extends StatefulWidget {
  final List<String> imagePaths;
  final int? limit;
  final Function(List<String> imagePaths)? onChanged;

  const ImageVerticalList({
    super.key,
    this.imagePaths = const [],
    this.onChanged,
    this.limit,
  });

  @override
  State<ImageVerticalList> createState() => _ImageVerticalListState();
}

class _ImageVerticalListState extends State<ImageVerticalList> {
  List<String> _imagePaths = [];
  int limit = 20;

  @override
  void initState() {
    super.initState();
    limit = widget.limit ?? limit;
    _imagePaths = widget.imagePaths;
  }

  void _onRemove(int index) {
    /// update state
    setState(() {
      _imagePaths.removeAt(index);
    });

    /// emit onChanged event
    widget.onChanged?.call(_imagePaths);
  }

  void _onAdd() {
    // show default image picker
    showPickupImageSource(
      context,
      onImagePathsAdded: (imagePaths) {
        // combine old and new list
        var newList = [..._imagePaths, ...imagePaths]
            .take(widget.limit ?? _imagePaths.length + imagePaths.length)
            .toList();

        /// update state
        setState(() {
          _imagePaths = newList;
        });

        /// emit onChanged event
        widget.onChanged?.call(newList);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => 16.height,
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: _imagePaths.length < limit
          ? _imagePaths.length + 1
          : _imagePaths.length,
      itemBuilder: (context, index) {
        if (_imagePaths.length < limit && index == _imagePaths.length) {
          return AddNewButton(
            onTap: _onAdd,
          );
        }

        return ImageVerticalListTile(
          imagePath: _imagePaths[index],
          onRemove: () {
            _onRemove(index);
          },
        );
      },
    );
  }
}
