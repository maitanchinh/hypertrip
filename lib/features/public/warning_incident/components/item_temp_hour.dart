import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/utils/date_time_utils.dart';
import 'package:nb_utils/nb_utils.dart';

class ItemTempHour extends StatelessWidget {
  final String hour;
  final int temp;
  final String icon;

  const ItemTempHour({
    Key? key,
    required this.hour,
    required this.temp,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(DateTimeUtils.convertToHHMMString(hour),
            style: AppStyle.fontOpenSanRegular
                .copyWith(fontSize: 16, color: AppColors.textGreyColor)),
        8.height,
        CachedNetworkImage(
          imageUrl: icon,
          width: 29,
          height: 24,
        ),
        8.height,
        Text(
          '$temp°C',
          style: AppStyle.fontOpenSanSemiBold.copyWith(fontSize: 14, color: Colors.black),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
