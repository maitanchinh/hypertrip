import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/widgets/text/p_text.dart';

class Section extends StatelessWidget {
  final Widget? child;
  final String? title;

  const Section({super.key, this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PText(
              title ?? '',
              color: AppColors.textGreyColor,
            ),
            const Divider(color: AppColors.textGreyColor),
            child ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
