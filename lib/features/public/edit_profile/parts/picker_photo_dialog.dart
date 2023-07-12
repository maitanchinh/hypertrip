import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:image_picker/image_picker.dart';

class PickerPhotoDialog extends StatefulWidget {
  final bool hasCrop;
  final String title;
  final bool isMultiImage;
  final Function(bool)? setLoadingCallBack;
  final Function(List<File>)? onSelected;
  final int numberImages;
  final Function(ImageSource source)? callback;

  const PickerPhotoDialog({
    Key? key,
    required this.title,
    this.hasCrop = false,
    this.isMultiImage = false,
    this.setLoadingCallBack,
    this.onSelected,
    this.numberImages = 0,
    this.callback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PickerPhotoDialogState();
  }
}

class _PickerPhotoDialogState extends State<PickerPhotoDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        InkWell(
          onTap: () => widget.callback?.call(ImageSource.camera),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 48,
            alignment: Alignment.centerLeft,
            child: const Text(
              takePicture,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.callback?.call(ImageSource.gallery),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 48,
            alignment: Alignment.centerLeft,
            child: const Text(
              gallery,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
