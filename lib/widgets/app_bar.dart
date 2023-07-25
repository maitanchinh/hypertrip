import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/widgets/button/action_button.dart';
import 'package:hypertrip/widgets/text/p_text.dart';
import 'package:nb_utils/nb_utils.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? titleStyle;
  final List<Widget>? actions;
  final bool implyLeading;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const MainAppBar({
    super.key,
    this.title = '',
    this.titleStyle,
    this.actions,
    this.implyLeading = false,
    this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: implyLeading
          ?
          // IconButton(
          //     onPressed: onTap ??
          //         () {
          //           Navigator.pop(context);
          //         },
          //     icon: Image.asset(
          //       AppAssets.icons_icon_arrow_back_png,
          //       color: AppColors.primaryColor,
          //       width: 20,
          //       height: 24,
          //     ),
          //   )
          Padding(
              padding: const EdgeInsets.only(left: 16),
              child: ActionButton(
                icon: AppAssets.icons_angle_left_svg,
                onPressed: onTap ??
                    () {
                      Navigator.pop(context);
                    },
              ),
            )
          : const SizedBox(),
      centerTitle: true,
      title: PText(
        title,
      ),
      elevation: 0,
      backgroundColor: backgroundColor ?? AppColors.bgLightColor,
      actions: actions != null && actions!.isNotEmpty
          ? List.generate(
              actions!.length,
              (index) => actions![actions!.length - index - 1],
            )
          : null,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(44);
}
