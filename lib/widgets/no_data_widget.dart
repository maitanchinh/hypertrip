import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/utils/message.dart';

class NoDataWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String content;
  final String? contentButton;
  const NoDataWidget({Key? key, this.onPressed, this.content = '', this.contentButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            contentButton ?? reload,
            style: AppStyle.fontOpenSanBold.copyWith(color: AppColors.textColor),
          ),
        ),
        Text(
          content,
          style: AppStyle.fontOpenSanBold.copyWith(color: AppColors.iconColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
