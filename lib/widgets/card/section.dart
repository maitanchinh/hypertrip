import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/widgets/text/p_text.dart';
import 'package:nb_utils/nb_utils.dart';

class Section extends StatelessWidget {
  final Widget? child;
  final String? title;

  const Section({super.key, this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title != null ? PText(
              title,
              color: AppColors.textGreyColor,
            ) : SizedBox.shrink(),
            title != null ? const Divider(color: AppColors.textGreyColor) : SizedBox.shrink(),
            child ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
