import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

/// pick an image from gallery or camera
Future<File?> pickImage(
  ImageSource source, {
  bool useCropper = false,
}) async {
  /// pick image from source
  final pickedImage = await ImagePicker().pickImage(source: source);

  /// return null if no image picked
  if (pickedImage == null) return null;

  /// convert picked image to file
  final fileImage = File(pickedImage.path);

  /// use cropper
  if (useCropper) return await _cropImage(fileImage);

  return fileImage;
}

/// pick multiple images from gallery
Future<List<File>> pickMultipleImages() async {
  /// pick multiple images from gallery
  final images = await ImagePicker().pickMultiImage();

  /// convert picked images to files
  final files = images.map((e) => File(e.path)).toList();

  return files;
}

/// crop an image and convert it to file
Future<File?> _cropImage(File file) async {
  final image = await ImageCropper().cropImage(
    sourcePath: file.path,
    aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),

    // todo: use global variable
    compressQuality: 100,
    maxWidth: 700,
    maxHeight: 700,

    compressFormat: ImageCompressFormat.jpg,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: label_cropper,
        toolbarColor: AppColors.primaryColor,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: label_cropper,
      ),
    ],
  );

  return image != null ? File(image.path) : null;
}
