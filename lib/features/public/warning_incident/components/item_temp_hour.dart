import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/date_time_utils.dart';

import '../../../../widgets/text/p_small_text.dart';

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
        PSmallText(DateTimeUtils.convertToHHMMString(hour),
            color: AppColors.textGreyColor,),
        CachedNetworkImage(
          imageUrl: icon,
          height: 40,
        ),
        PSmallText(
          '$temp°C',
          color: AppColors.textColor,
        )
      ],
    );
  }
}
