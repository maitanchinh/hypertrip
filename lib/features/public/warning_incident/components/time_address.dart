import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/utils/date_time_utils.dart';

class TimeAddress extends StatelessWidget {
  final String time;
  const TimeAddress({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Today ',
            style: AppStyle.fontOpenSanRegular.copyWith(fontSize: 14, color: AppColors.textColor)),
        Text(DateTimeUtils.convertToHHMMString(time),
            style: AppStyle.fontOpenSanRegular.copyWith(fontSize: 14, color: AppColors.textColor))
      ],
    );
  }
}
