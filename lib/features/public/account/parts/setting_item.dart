import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:nb_utils/nb_utils.dart';

class SettingItem extends StatelessWidget {
  final String icon;
  final Color? iconColor;
  final String content;
  final VoidCallback? callBack;

  const SettingItem({
    Key? key,
    required this.icon,
    required this.content,
    this.iconColor,
    this.callBack,
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
                  decoration: BoxDecoration(shape: BoxShape.circle, color: iconColor),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(icon, fit: BoxFit.fitHeight),
                  ),
                ),
                10.width,
                Text(content,
                    style: AppStyle.fontOpenSanRegular
                        .copyWith(fontSize: 16, color: AppColors.textColor)),
              ],
            ),
            SvgPicture.asset(AppAssets.icons_ic_chevron_right_svg),
          ],
        ),
      ),
    );
  }
}
