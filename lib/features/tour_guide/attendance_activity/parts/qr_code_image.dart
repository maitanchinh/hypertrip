import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeImage extends StatelessWidget {
  final String? data;
  const QrCodeImage({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    const error = 'error';
    var _data = data ?? error;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: QrImageView(
        data: _data,
        version: QrVersions.auto,
        size: 150.0,
      ),
    );
  }
}
