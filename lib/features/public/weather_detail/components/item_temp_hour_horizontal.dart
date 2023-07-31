import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/widgets/space/gap.dart';
import 'package:hypertrip/widgets/text/p_small_text.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../widgets/text/p_text.dart';

class ItemTempHourHorizontal extends StatelessWidget {
  final String content;
  final String day;
  final int temp;
  final String icon;

  const ItemTempHourHorizontal({
    Key? key,
    required this.content,
    required this.day,
    required this.temp,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PSmallText(content,
                  size: 16, color: AppColors.textColor,),
              PSmallText(day, size: 16,),
            ],
          ),
        ),
        Gap.k8.width,
        PText(
          '$temp°C',
          size: 16,
        ),
        Gap.k8.width,
        CachedNetworkImage(
          imageUrl: icon,
          width: 39,
          height: 44,
        )
      ],
    );
  }
}
