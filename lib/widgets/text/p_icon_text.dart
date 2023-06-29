import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/widgets/text/p_small_text.dart';

class PIconText extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Color color;
  final Color iconColor;

  const PIconText(
    this.text, {
    super.key,
    this.icon,
    this.color = AppColors.textGreyColor,
    this.iconColor = AppColors.textGreyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 5),
        PSmallText(text, color: color)
      ],
    );
  }
}
