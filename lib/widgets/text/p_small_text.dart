import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';

class PSmallText extends StatelessWidget {
  final Color color;
  final String? text;
  final double size;
  final double height;
  final TextAlign? textAlign;

  const PSmallText(
    this.text, {
    super.key,
    this.color = AppColors.textGreyColor,
    this.size = 14,
    this.height = 1.2,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: size,
        height: height,
      ),
    );
  }
}
