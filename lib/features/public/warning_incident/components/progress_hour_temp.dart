import 'package:flutter/material.dart';
import 'package:hypertrip/features/public/warning_incident/components/vertical_progressbar.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';

class ProgressHourTermp extends StatelessWidget {
  final double value;
  final String title;
  final int temp;
  const ProgressHourTermp({Key? key, required this.value, required this.title, required this.temp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        VerticalProgressBar(
          color: AppColors.primaryColor,
          backgroundColor: const Color(0xFFF1FBFF).withOpacity(0.3),
          value: value,
        ),
        Text(
          title,
          style: AppStyle.fontOpenSanRegular.copyWith(fontSize: 14, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        Text(
          '$temp°C',
          style: AppStyle.fontOpenSanSemiBold.copyWith(fontSize: 14, color: Colors.black),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
