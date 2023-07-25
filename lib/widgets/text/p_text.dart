import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';

class PText extends StatelessWidget {
  final Color color;
  final String? text;
  final double size;
  final TextOverflow overflow;
  final int? maxLines;
  final FontWeight? weight;

  const PText(
    this.text, {
    super.key,
    this.color = AppColors.textColor,
    this.size = 18,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines = 1,
    this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: size,
        fontWeight: weight ?? FontWeight.w500,
      ),
    );
  }
}
