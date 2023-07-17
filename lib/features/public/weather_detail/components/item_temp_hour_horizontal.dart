import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:nb_utils/nb_utils.dart';

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
          width: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(content,
                  style: AppStyle.fontOpenSanRegular
                      .copyWith(fontSize: 16, color: AppColors.textColor)),
              Text(day,
                  style: AppStyle.fontOpenSanRegular
                      .copyWith(fontSize: 16, color: AppColors.textGreyColor)),
            ],
          ),
        ),
        8.width,
        Text(
          '$temp°C',
          style: AppStyle.fontOpenSanSemiBold.copyWith(fontSize: 16, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        8.width,
        CachedNetworkImage(
          imageUrl: icon,
          width: 39,
          height: 44,
        )
      ],
    );
  }
}
