import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/utils/app_style.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? titleStyle;
  final List<Widget>? actions;
  final bool implyLeading;
  final VoidCallback? onTap;

  const MainAppBar(
      {super.key, this.title = '', this.titleStyle, this.actions, this.implyLeading = false,this.onTap,});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: implyLeading
          ? IconButton(
              onPressed: onTap ??
                  () {
                    Navigator.pop(context);
                  },
              icon: Image.asset(
                AppAssets.icons_icon_arrow_back_png,
                color: AppColors.primaryColor,
                width: 20,
                height: 24,
              ),
            )
          : const SizedBox(),
      centerTitle: true,
      title: Text(
        title,
        style: titleStyle ?? AppStyle.fontOpenSanSemiBold.copyWith(color: Colors.black),
      ),
      elevation: 0,
      backgroundColor: AppColors.bgLightColor,
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
