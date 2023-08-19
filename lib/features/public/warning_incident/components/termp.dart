import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:nb_utils/nb_utils.dart';

class Termp extends StatelessWidget {
  final int temp;
  final String conditionText;
  const Termp({Key? key, required this.temp, this.conditionText = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$temp°C',
            style: AppStyle.fontOpenSanSemiBold.copyWith(fontSize: 40, color: AppColors.textColor)),
        Text(conditionText,
            style: AppStyle.fontOpenSanRegular.copyWith(fontSize: 14, color: AppColors.textColor)),
      ],
    );
  }
}
