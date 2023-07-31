import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../widgets/text/p_text.dart';

class SettingItem extends StatelessWidget {
  final String icon;
  final Color? greyColor;
  final Color? iconColor;
  final String content;
  final VoidCallback? callBack;

  const SettingItem({
    Key? key,
    required this.icon,
    required this.content,
    this.greyColor,
    this.callBack,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: greyColor),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Transform.scale(
                      scale: 0.8,
                      child: SvgPicture.asset(
                        icon,
                        fit: BoxFit.fitHeight,
                        color: iconColor,
                      ),
                    ),
                  ),
                ),
                10.width,
                PText(
                  content,
                  size: 16,
                  weight: FontWeight.normal,
                )
              ],
            ),
            SizedBox(
              width: 24,
              child: Transform.scale(
                scale: 0.5,
                child: SvgPicture.asset(
                  AppAssets.icons_angle_right_svg,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
