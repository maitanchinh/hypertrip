import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';

class Information extends StatelessWidget {
  final int count;
  final String status;

  const Information({Key? key, this.count = 0, this.status = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text: "$count\n",
            style: AppStyle.fontOpenSanBold.copyWith(fontSize: 20, color: AppColors.textColor),
          ),
          TextSpan(
            text: status,
            style: AppStyle.fontOpenSanRegular.copyWith(fontSize: 16, color: AppColors.iconColor),
          ),
        ]));
  }
}
