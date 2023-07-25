import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:nb_utils/nb_utils.dart';

class ItemWeather extends StatelessWidget {
  final String icon;
  final String text;
  const ItemWeather({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon,color: AppColors.primaryColor),
        8.width,
        Text(text, style: AppStyle.fontOpenSanRegular.copyWith(fontSize: 14, color: AppColors.textColor)),
      ],
    );
  }
}
